#include <stdlib.h>
#include <string.h> // For memset, if used

#define MAX_NODES 200005
#define MAX_EDGES 100005

typedef struct NodeData {
    int val;
    int id;
} NodeData;

int compareNodeData(const void* a, const void* b) {
    return ((NodeData*)a)->val - ((NodeData*)b)->val;
}

int get_id_from_val(NodeData* sorted_unique_nodes, int count, int val) {
    NodeData key = {val, 0};
    NodeData* found = bsearch(&key, sorted_unique_nodes, count, sizeof(NodeData), compareNodeData);
    return found->id;
}

typedef struct Edge {
    int u_id;
    int v_id;
} Edge;

int compareEdges(const void* a, const void* b) {
    Edge* edgeA = (Edge*)a;
    Edge* edgeB = (Edge*)b;
    if (edgeA->u_id != edgeB->u_id) {
        return edgeA->u_id - edgeB->u_id;
    }
    return edgeA->v_id - edgeB->v_id;
}

int out_degree[MAX_NODES];
int in_degree[MAX_NODES];
int adj_start_idx[MAX_NODES]; // Starting index in all_edges_dest for edges from a node
int adj_ptr[MAX_NODES];       // Current pointer for DFS traversal in all_edges_dest
int all_edges_dest[MAX_EDGES]; // Stores all destination node IDs, grouped by source

int path_nodes[MAX_EDGES + 1];
int path_nodes_idx;

int* id_to_val_map;

void findEulerPathNodes(int u_id) {
    // Traverse all outgoing edges from u_id that haven't been visited yet
    while (adj_ptr[u_id] != -1 && adj_ptr[u_id] < adj_start_idx[u_id] + out_degree[u_id]) {
        int v_id = all_edges_dest[adj_ptr[u_id]];
        adj_ptr[u_id]++; // "Remove" edge (u_id, v_id) by advancing pointer
        findEulerPathNodes(v_id);
    }
    // After exploring all edges from u_id, add u_id to the path
    path_nodes[path_nodes_idx++] = u_id;
}

int** validArrangement(int** pairs, int pairsSize, int* pairsColSize, int* returnSize, int** returnColumnSizes) {
    // 1. Collect all unique node values from pairs
    NodeData* all_nodes_temp = (NodeData*)malloc(sizeof(NodeData) * pairsSize * 2);
    int temp_node_count = 0;

    for (int i = 0; i < pairsSize; i++) {
        all_nodes_temp[temp_node_count++].val = pairs[i][0];
        all_nodes_temp[temp_node_count++].val = pairs[i][1];
    }

    // Sort to easily find unique values
    qsort(all_nodes_temp, temp_node_count, sizeof(NodeData), compareNodeData);

    // Remove duplicates and assign compressed IDs (0 to num_unique_nodes - 1)
    NodeData* unique_nodes = (NodeData*)malloc(sizeof(NodeData) * temp_node_count); // Max possible unique nodes
    int num_unique_nodes = 0;
    if (temp_node_count > 0) {
        unique_nodes[num_unique_nodes].val = all_nodes_temp[0].val;
        unique_nodes[num_unique_nodes].id = num_unique_nodes;
        num_unique_nodes++;

        for (int i = 1; i < temp_node_count; i++) {
            if (all_nodes_temp[i].val != unique_nodes[num_unique_nodes - 1].val) {
                unique_nodes[num_unique_nodes].val = all_nodes_temp[i].val;
                unique_nodes[num_unique_nodes].id = num_unique_nodes;
                num_unique_nodes++;
            }
        }
    }
    free(all_nodes_temp);

    // Create a map from internal ID back to original value
    id_to_val_map = (int*)malloc(sizeof(int) * num_unique_nodes);
    for (int i = 0; i < num_unique_nodes; i++) {
        id_to_val_map[unique_nodes[i].id] = unique_nodes[i].val;
    }

    // Initialize degrees and adjacency list pointers
    for (int i = 0; i < num_unique_nodes; i++) {
        out_degree[i] = 0;
        in_degree[i] = 0;
        adj_start_idx[i] = -1; // -1 indicates no outgoing edges initially
    }

    // 2. Populate degrees and a temporary list of edges (in ID form)
    Edge* temp_edges = (Edge*)malloc(sizeof(Edge) * pairsSize);
    for (int i = 0; i < pairsSize; i++) {
        int u_val = pairs[i][0];
        int v_val = pairs[i][1];

        int u_id = get_id_from_val(unique_nodes, num_unique_nodes, u_val);
        int v_id = get_id_from_val(unique_nodes, num_unique_nodes, v_val);

        out_degree[u_id]++;
        in_degree[v_id]++;

        temp_edges[i].u_id = u_id;
        temp_edges[i].v_id = v_id;
    }

    // 3. Sort the temporary edge list by source ID
    qsort(temp_edges, pairsSize, sizeof(Edge), compareEdges);

    // 4. Populate `all_edges_dest` and `adj_start_idx`
    int current_edge_idx = 0;
    for (int i = 0; i < pairsSize; i++) {
        int u_id = temp_edges[i].u_id;
        int v_id = temp_edges[i].v_id;

        if (adj_start_idx[u_id] == -1) { // First edge for this u_id
            adj_start_idx[u_id] = current_edge_idx;
        }
        all_edges_dest[current_edge_idx++] = v_id;
    }
    free(temp_edges);

    // Initialize `adj_ptr` for nodes with outgoing edges
    for (int i = 0; i < num_unique_nodes; i++) {
        if (out_degree[i] > 0) {
            adj_ptr[i] = adj_start_idx[i];
        } else {
            adj_ptr[i] = -1; // No outgoing edges, pointer won't be used
        }
    }

    // 5. Find the starting node for the Eulerian path
    int start_node_id = -1;
    for (int i = 0; i < num_unique_nodes; i++) {
        if (out_degree[i] == in_degree[i] + 1) { // Node with out-degree = in-degree + 1
            start_node_id = i;
            break;
        }
    }
    // If no such node, it's an Eulerian circuit. Pick any node with out_degree > 0.
    if (start_node_id == -1) {
        for (int i = 0; i < num_unique_nodes; i++) {
            if (out_degree[i] > 0) {
                start_node_id = i;
                break;
            }
        }
    }

    // 6. Perform DFS to find the Eulerian path
    path_nodes_idx = 0;
    findEulerPathNodes(start_node_id);

    // 7. Construct the result array from `path_nodes`
    *returnSize = pairsSize;
    *returnColumnSizes = (int*)malloc(sizeof(int) * pairsSize);
    int** result_path = (int**)malloc(sizeof(int*) * pairsSize);

    // `path_nodes` is built in reverse order: [last_node, second_to_last, ..., first_node]
    // We need pairs: [[first_node, second_node], [second_node, third_node], ...]
    // So, `path_nodes[pairsSize - i]` is the `u` part and `path_nodes[pairsSize - 1 - i]` is the `v` part.
    for (int i = 0; i < pairsSize; i++) {
        result_path[i] = (int*)malloc(sizeof(int) * 2);
        result_path[i][0] = id_to_val_map[path_nodes[pairsSize - i]];
        result_path[i][1] = id_to_val_map[path_nodes[pairsSize - 1 - i]];
        (*returnColumnSizes)[i] = 2;
    }

    // Free temporary memory
    free(unique_nodes);
    free(id_to_val_map);

    return result_path;
}