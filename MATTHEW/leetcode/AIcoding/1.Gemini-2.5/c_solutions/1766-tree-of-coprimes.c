#include <stdlib.h>
#include <stdbool.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

static bool is_coprime[51][51];
static bool is_coprime_initialized = false;

typedef struct {
    int node_id;
    int depth;
} StackEntry;

typedef struct {
    StackEntry data[100005];
    int top;
} ValueStack;

static ValueStack stacks[51];

static int* g_nums;
static int* g_ans;

struct AdjNode {
    int val;
    struct AdjNode* next;
};
static struct AdjNode* adj[100005];

void dfs(int u, int parent, int current_depth) {
    int max_depth_found = -1;
    int best_ancestor_id = -1;

    for (int v = 1; v <= 50; ++v) {
        if (is_coprime[g_nums[u]][v]) {
            if (stacks[v].top > 0) {
                StackEntry* top_entry = &stacks[v].data[stacks[v].top - 1];
                if (top_entry->depth > max_depth_found) {
                    max_depth_found = top_entry->depth;
                    best_ancestor_id = top_entry->node_id;
                } else if (top_entry->depth == max_depth_found) {
                    if (top_entry->node_id > best_ancestor_id) {
                        best_ancestor_id = top_entry->node_id;
                    }
                }
            }
        }
    }
    g_ans[u] = best_ancestor_id;

    stacks[g_nums[u]].data[stacks[g_nums[u]].top].node_id = u;
    stacks[g_nums[u]].data[stacks[g_nums[u]].top].depth = current_depth;
    stacks[g_nums[u]].top++;

    struct AdjNode* curr = adj[u];
    while (curr != NULL) {
        if (curr->val != parent) {
            dfs(curr->val, u, current_depth + 1);
        }
        curr = curr->next;
    }

    stacks[g_nums[u]].top--;
}

void add_edge(int u, int v) {
    struct AdjNode* newNode = (struct AdjNode*)malloc(sizeof(struct AdjNode));
    newNode->val = v;
    newNode->next = adj[u];
    adj[u] = newNode;

    newNode = (struct AdjNode*)malloc(sizeof(struct AdjNode));
    newNode->val = u;
    newNode->next = adj[v];
    adj[v] = newNode;
}

int* getCoprimes(int* nums, int numsSize, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    g_nums = nums;
    *returnSize = numsSize;
    g_ans = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; ++i) {
        adj[i] = NULL;
    }
    for (int i = 1; i <= 50; ++i) {
        stacks[i].top = 0;
    }

    for (int i = 0; i < edgesSize; ++i) {
        add_edge(edges[i][0], edges[i][1]);
    }

    if (!is_coprime_initialized) {
        for (int i = 1; i <= 50; ++i) {
            for (int j = 1; j <= 50; ++j) {
                is_coprime[i][j] = (gcd(i, j) == 1);
            }
        }
        is_coprime_initialized = true;
    }

    dfs(0, -1, 0);

    for (int i = 0; i < numsSize; ++i) {
        struct AdjNode* curr = adj[i];
        while (curr != NULL) {
            struct AdjNode* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }

    return g_ans;
}