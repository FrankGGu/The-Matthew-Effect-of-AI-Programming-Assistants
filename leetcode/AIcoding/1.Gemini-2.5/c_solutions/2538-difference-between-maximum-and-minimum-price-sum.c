#include <stdlib.h>
#include <limits.h>

typedef struct AdjListNode {
    int dest;
    struct AdjListNode* next;
} AdjListNode;

typedef struct AdjList {
    AdjListNode* head;
} AdjList;

typedef struct Graph {
    int V;
    AdjList* array;
} Graph;

AdjListNode* newAdjListNode(int dest) {
    AdjListNode* newNode = (AdjListNode*)malloc(sizeof(AdjListNode));
    newNode->dest = dest;
    newNode->next = NULL;
    return newNode;
}

Graph* createGraph(int V) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->V = V;
    graph->array = (AdjList*)malloc(V * sizeof(AdjList));
    for (int i = 0; i < V; ++i) {
        graph->array[i].head = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int src, int dest) {
    AdjListNode* newNode = newAdjListNode(dest);
    newNode->next = graph->array[src].head;
    graph->array[src].head = newNode;

    newNode = newAdjListNode(src);
    newNode->next = graph->array[dest].head;
    graph->array[dest].head = newNode;
}

long long global_max_sum;
long long global_min_sum;

long long* dfs(int u, int p, Graph* graph, int* prices) {
    long long* result = (long long*)malloc(2 * sizeof(long long));
    result[0] = prices[u]; // max_path_from_u_down
    result[1] = prices[u]; // min_path_from_u_down

    // These variables track the best single branch sums from children to combine for a path through u.
    // They store the *additional* sum from child's subtree (i.e., child_path_sum - prices[child]).
    // We need to find the two largest positive additions for max_sum, and two smallest negative additions for min_sum.
    // Or, more simply, track the full max_path_from_v_down and min_path_from_v_down values.
    // Let's track the actual max_path_from_v_down values.
    long long first_max_child_path_val = LLONG_MIN;
    long long second_max_child_path_val = LLONG_MIN;
    long long first_min_child_path_val = LLONG_MAX;
    long long second_min_child_path_val = LLONG_MAX;

    AdjListNode* temp = graph->array[u].head;
    while (temp != NULL) {
        int v = temp->dest;
        if (v == p) {
            temp = temp->next;
            continue;
        }

        long long* child_res = dfs(v, u, graph, prices);
        long long max_path_from_v_down = child_res[0];
        long long min_path_from_v_down = child_res[1];
        free(child_res);

        // Update max_path_from_u_down and min_path_from_u_down
        // A path starting at u, going down into v's subtree
        result[0] = (result[0] > (long long)prices[u] + max_path_from_v_down) ? result[0] : ((long long)prices[u] + max_path_from_v_down);
        result[1] = (result[1] < (long long)prices[u] + min_path_from_v_down) ? result[1] : ((long long)prices[u] + min_path_from_v_down);

        // Update top 2 max/min child path values for combining two branches through u
        if (max_path_from_v_down > first_max_child_path_val) {
            second_max_child_path_val = first_max_child_path_val;
            first_max_child_path_val = max_path_from_v_down;
        } else if (max_path_from_v_down > second_max_child_path_val) {
            second_max_child_path_val = max_path_from_v_down;
        }

        if (min_path_from_v_down < first_min_child_path_val) {
            second_min_child_path_val = first_min_child_path_val;
            first_min_child_path_val = min_path_from_v_down;
        } else if (min_path_from_v_down < second_min_child_path_val) {
            second_min_child_path_val = min_path_from_v_down;
        }

        temp = temp->next;
    }

    // Update global max/min with paths that pass through u
    // 1. Path is just u itself (already covered by initial global_max/min_sum and result[0]/result[1] updates)
    // 2. Path starts at u and goes down into one subtree (covered by result[0]/result[1] and global_max/min_sum updates)
    // 3. Path combines two branches through u:
    //    prices[u] + (first_max_child_path_val - prices[v1]) + (second_max_child_path_val - prices[v2])
    //    This is equivalent to prices[u] + (first_max_child_path_val - prices[u]) + (second_max_child_path_val - prices[u])
    //    No, this is wrong. It should be prices[u] + (max_path_from_v1_down - prices[v1]) + (max_path_from_v2_down - prices[v2]).
    //    The `max_path_from_v_down` already includes `prices[v]`. So `max_path_from_v_down - prices[v]` is the path sum *below* `v`.
    //    So, path through `u` combining two branches `v1` and `v2` is `prices[u] + (max_path_from_v1_down - prices[v1]) + (max_path_from_v2_down - prices[v2])`.
    //    This is `prices[u] + (max_path_from_v1_down - prices[v1]) + (max_path_from_v2_down - prices[v2])`.

    // To correctly calculate the path through `u` combining two branches, we need to know the path *from* `v` downwards *excluding* `v`.
    // Let `max_path_from_v_down_excluding_v = max_path_from_v_down - prices[v]`.
    // We need to keep track of the largest and second largest `max_path_from_v_down_excluding_v`.
    // This is getting too complex with C arrays. Let's use simpler logic.

    // The current `result[0]` and `result[1]` are max/min paths starting at `u` and going down ONE branch.
    // Update global max/min with these paths.
    global_max_sum = (global_max_sum > result[0]) ? global_max_sum : result[0];
    global_min_sum = (global_min_sum < result[1]) ? global_min_sum : result[1];

    // Consider paths that pass through `u` and combine two child branches.
    // The sum is `prices[u] + (max_path_from_v1_down - prices[v1]) + (max_path_from_v2_down - prices[v2])`
    // No, it's simpler: `prices[u] + max_path_from_v1_down + max_path_from_v2_down - prices[v1] - prices[v2]`.
    // The problem is that `max_path_from_v_down` can be negative, so `max_path_from_v_down - prices[v]` can be less than 0.
    // We want the maximum path sum, so if `max_path_from_v_down - prices[v]` is negative, we shouldn't take it.
    // This is why standard maximum path sum solutions use `max(0LL, child_path_sum)`.
    // But here we need to find the overall max/min path sum, including negative values.

    // Let's reconsider the definition of `max_path_from_u_down` and `min_path_from_u_down`
    // These are the values returned by the DFS for node `u`.
    // They represent the max/min path sum starting at `u` and going *downwards* into one of its subtrees (or just `u` itself).

    // `max_path_from_u_down`: `max(prices[u], prices[u] + max_path_from_child_down)`
    // `min_path_from_u_down`: `min(prices[u], prices[u] + min_path_from_child_down)`

    // When combining two branches through `u`:
    // Max path sum: `prices[u] + (max_path_from_v1_down - prices[v1]) + (max_path_from_v2_down - prices[v2])`
    // Min path sum: `prices[u] + (min_path_from_v1_down - prices[v1]) + (min_path_from_v2_down - prices[v2])`

    // Let's store `max_path_from_v_down_excluding_v` and `min_path_from_v_down_excluding_v`
    long long first_max_ext = LLONG_MIN; // Max extension from a child, excluding child's price
    long long second_max_ext = LLONG_MIN;
    long long first_min_ext = LLONG_MAX; // Min extension from a child, excluding child's price
    long long second_min_ext = LLONG_MAX;

    temp = graph->array[u].head;
    while (temp != NULL) {
        int v = temp->dest;
        if (v == p) {
            temp =