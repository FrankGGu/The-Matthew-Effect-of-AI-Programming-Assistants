typedef struct {
    char* key;
    double value;
    UT_hash_handle hh;
} HashNode;

typedef struct {
    char* key;
    HashNode* neighbors;
    UT_hash_handle hh;
} GraphNode;

double dfs(GraphNode* graph, char* start, char* end, HashNode* visited) {
    if (!graph || !start || !end) return -1.0;

    GraphNode* node;
    HASH_FIND_STR(graph, start, node);
    if (!node) return -1.0;

    if (strcmp(start, end) == 0) return 1.0;

    HashNode* visited_node;
    HASH_FIND_STR(visited, start, visited_node);
    if (visited_node) return -1.0;

    visited_node = malloc(sizeof(HashNode));
    visited_node->key = start;
    visited_node->value = 1.0;
    HASH_ADD_STR(visited, key, visited_node);

    HashNode* neighbor;
    for (neighbor = node->neighbors; neighbor != NULL; neighbor = neighbor->hh.next) {
        double result = dfs(graph, neighbor->key, end, visited);
        if (result != -1.0) {
            HASH_DEL(visited, visited_node);
            free(visited_node);
            return neighbor->value * result;
        }
    }

    HASH_DEL(visited, visited_node);
    free(visited_node);
    return -1.0;
}

double* calcEquation(char*** equations, int equationsSize, int* equationsColSize, double* values, int valuesSize, char*** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    GraphNode* graph = NULL;

    for (int i = 0; i < equationsSize; i++) {
        char* a = equations[i][0];
        char* b = equations[i][1];
        double val = values[i];

        GraphNode* node_a;
        HASH_FIND_STR(graph, a, node_a);
        if (!node_a) {
            node_a = malloc(sizeof(GraphNode));
            node_a->key = a;
            node_a->neighbors = NULL;
            HASH_ADD_STR(graph, key, node_a);
        }

        GraphNode* node_b;
        HASH_FIND_STR(graph, b, node_b);
        if (!node_b) {
            node_b = malloc(sizeof(GraphNode));
            node_b->key = b;
            node_b->neighbors = NULL;
            HASH_ADD_STR(graph, key, node_b);
        }

        HashNode* neighbor_ab = malloc(sizeof(HashNode));
        neighbor_ab->key = b;
        neighbor_ab->value = val;
        HASH_ADD_STR(node_a->neighbors, key, neighbor_ab);

        HashNode* neighbor_ba = malloc(sizeof(HashNode));
        neighbor_ba->key = a;
        neighbor_ba->value = 1.0 / val;
        HASH_ADD_STR(node_b->neighbors, key, neighbor_ba);
    }

    double* results = malloc(queriesSize * sizeof(double));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        char* start = queries[i][0];
        char* end = queries[i][1];

        HashNode* visited = NULL;
        results[i] = dfs(graph, start, end, visited);
    }

    GraphNode *current_node, *tmp_node;
    HASH_ITER(hh, graph, current_node, tmp_node) {
        HashNode *current_neighbor, *tmp_neighbor;
        HASH_ITER(hh, current_node->neighbors, current_neighbor, tmp_neighbor) {
            HASH_DEL(current_node->neighbors, current_neighbor);
            free(current_neighbor);
        }
        HASH_DEL(graph, current_node);
        free(current_node);
    }

    return results;
}