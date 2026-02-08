#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

typedef struct {
    AdjNode** heads;
    int numNodes;
} Graph;

void addEdge(Graph* graph, int u, int v) {
    AdjNode* newNode1 = (AdjNode*)malloc(sizeof(AdjNode));
    newNode1->val = v;
    newNode1->next = graph->heads[u];
    graph->heads[u] = newNode1;

    AdjNode* newNode2 = (AdjNode*)malloc(sizeof(AdjNode));
    newNode2->val = u;
    newNode2->next = graph->heads[v];
    graph->heads[v] = newNode2;
}

int* g_amount;
int* g_bob_times;
long long g_max_profit;
Graph* g_graph;

void dfs_alice(int u, int parent, int current_time_alice, long long current_profit_so_far) {
    long long node_value = g_amount[u];
    int t_bob = g_bob_times[u];

    if (current_time_alice > t_bob) {
        node_value = 0;
    } else if (current_time_alice == t_bob) {
        node_value /= 2;
    }

    current_profit_so_far += node_value;

    int is_leaf = 1;
    AdjNode* current = g_graph->heads[u];
    while (current != NULL) {
        if (current->val != parent) {
            is_leaf = 0;
            dfs_alice(current->val, u, current_time_alice + 1, current_profit_so_far);
        }
        current = current->next;
    }

    if (is_leaf) {
        if (current_profit_so_far > g_max_profit) {
            g_max_profit = current_profit_so_far;
        }
    }
}

int mostProfitablePath(int** edges, int edgesSize, int* edgesColSize, int* amount, int amountSize, int bob) {
    int N = amountSize;

    Graph graph;
    graph.numNodes = N;
    graph.heads = (AdjNode**)calloc(N, sizeof(AdjNode*));

    for (int i = 0; i < edgesSize; ++i) {
        addEdge(&graph, edges[i][0], edges[i][1]);
    }

    g_graph = &graph;
    g_amount = amount;

    int* bob_dist_from_start = (int*)malloc(N * sizeof(int));
    int* bob_parent_on_path = (int*)malloc(N * sizeof(int));

    for (int i = 0; i < N; ++i) {
        bob_dist_from_start[i] = -1;
        bob_parent_on_path[i] = -1;
    }

    int* queue = (int*)malloc(N * sizeof(int));
    int head = 0, tail = 0;

    queue[tail++] = bob;
    bob_dist_from_start[bob] = 0;

    while (head < tail) {
        int u = queue[head++];
        if (u == 0) {
            break;
        }

        AdjNode* current = graph.heads[u];
        while (current != NULL) {
            int v = current->val;
            if (bob_dist_from_start[v] == -1) {
                bob_dist_from_start[v] = bob_dist_from_start[u] + 1;
                bob_parent_on_path[v] = u;
                queue[tail++] = v;
            }
            current = current->next;
        }
    }

    g_bob_times = (int*)malloc(N * sizeof(int));
    for (int i = 0; i < N; ++i) {
        g_bob_times[i] = INT_MAX;
    }

    int curr_node_on_path = 0;
    while (curr_node_on_path != -1) {
        if (bob_dist_from_start[curr_node_on_path] != -1) {
            g_bob_times[curr_node_on_path] = bob_dist_from_start[curr_node_on_path];
        }
        if (curr_node_on_path == bob) break;
        curr_node_on_path = bob_parent_on_path[curr_node_on_path];
    }

    g_max_profit = LLONG_MIN;

    dfs_alice(0, -1, 0, 0);

    free(bob_dist_from_start);
    free(bob_parent_on_path);
    free(queue);
    free(g_bob_times);

    for (int i = 0; i < N; ++i) {
        AdjNode* current = graph.heads[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(graph.heads);

    return (int)g_max_profit;
}