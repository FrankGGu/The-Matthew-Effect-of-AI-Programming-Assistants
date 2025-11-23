#include <stdlib.h> // For malloc, free

typedef struct AdjNode {
    int dest;
    int type; // 0 for original u -> dest, 1 for original dest -> u
    struct AdjNode* next;
} AdjNode;

typedef struct Graph {
    int V;
    AdjNode** adj;
} Graph;

AdjNode* newAdjNode(int dest, int type) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->dest = dest;
    newNode->type = type;
    newNode->next = NULL;
    return newNode;
}

Graph* createGraph(int V) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->V = V;
    graph->adj = (AdjNode**)malloc(V * sizeof(AdjNode*));
    for (int i = 0; i < V; ++i) {
        graph->adj[i] = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int u, int v) {
    // u -> v (original)
    AdjNode* node_uv = newAdjNode(v, 0);
    node_uv->next = graph->adj[u];
    graph->adj[u] = node_uv;

    // v -> u (reversed perspective for DFS traversal)
    AdjNode* node_vu = newAdjNode(u, 1);
    node_vu->next = graph->adj[v];
    graph->adj[v] = node_vu;
}

int* dp; // dp[i] stores min reversals if i is the root
Graph* global_graph; // Global pointer to graph for easier access in DFS
int min_reversals_global; // To store the minimum found so far

int dfs1(int u, int parent) {
    int current_reversals_for_subtree = 0;
    AdjNode* temp = global_graph->adj[u];
    while (temp != NULL) {
        int v = temp->dest;
        int type = temp->type; // 0 for original u -> v, 1 for original v -> u
        if (v == parent) {
            temp = temp->next;
            continue;
        }

        if (type == 0) { // Original edge u -> v. No reversal needed for this edge itself.
            current_reversals_for_subtree += dfs1(v, u);
        } else { // Original edge v -> u. This edge needs reversal if u is parent of v.
            current_reversals_for_subtree += dfs1(v, u) + 1;
        }
        temp = temp->next;
    }
    return current_reversals_for_subtree;
}

void dfs2(int u, int parent) {
    if (dp[u] < min_reversals_global) {
        min_reversals_global = dp[u];
    }

    AdjNode* temp = global_graph->adj[u];
    while (temp != NULL) {
        int v = temp->dest;
        int type = temp->type; // 0 for original u -> v, 1 for original v -> u
        if (v == parent) {
            temp = temp->next;
            continue;
        }

        // Calculate dp[v] based on dp[u]
        if (type == 0) { // Original edge u -> v
            // When u was root, u->v cost 0.
            // When v becomes root, v->u costs 1.
            dp[v] = dp[u] + 1;
        } else { // Original edge v -> u
            // When u was root, v->u cost 1.
            // When v becomes root, v->u costs 0.
            dp[v] = dp[u] - 1;
        }
        dfs2(v, u);
        temp = temp->next;
    }
}

void freeGraph(Graph* graph) {
    for (int i = 0; i < graph->V; ++i) {
        AdjNode* current = graph->adj[i];
        while (current != NULL) {
            AdjNode* next = current->next;
            free(current);
            current = next;
        }
    }
    free(graph->adj);
    free(graph);
}

int minEdgeReversals(int n, int** edges, int edgesSize, int* edgesColSize) {
    Graph* graph = createGraph(n);
    global_graph = graph; // Set global graph pointer

    for (int i = 0; i < edgesSize; ++i) {
        addEdge(graph, edges[i][0], edges[i][1]);
    }

    dp = (int*)malloc(n * sizeof(int));

    // DFS1: Calculate reversals if node 0 is the root
    dp[0] = dfs1(0, -1);

    // Initialize min_reversals_global with dp[0]
    min_reversals_global = dp[0];

    // DFS2: Calculate reversals for all other nodes by re-rooting
    // and update min_reversals_global during traversal
    dfs2(0, -1);

    int result = min_reversals_global;

    free(dp);
    freeGraph(graph); // Free graph memory
    return result;
}