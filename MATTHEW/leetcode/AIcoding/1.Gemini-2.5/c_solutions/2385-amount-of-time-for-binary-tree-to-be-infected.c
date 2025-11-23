#include <stdlib.h>
#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#define MAX_NODES 100001

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

AdjNode* adj[MAX_NODES];
AdjNode adj_pool[2 * MAX_NODES];
int adj_pool_idx;

int queue[MAX_NODES];
int head, tail;
bool visited[MAX_NODES];

void addEdge(int u, int v) {
    adj_pool[adj_pool_idx].val = v;
    adj_pool[adj_pool_idx].next = adj[u];
    adj[u] = &adj_pool[adj_pool_idx];
    adj_pool_idx++;
}

void buildGraph(struct TreeNode* root, int parent_val) {
    if (!root) return;

    if (parent_val != -1) {
        addEdge(root->val, parent_val);
        addEdge(parent_val, root->val);
    }

    buildGraph(root->left, root->val);
    buildGraph(root->right, root->val);
}

int bfs(int start_node_val) {
    head = 0;
    tail = 0;

    queue[tail++] = start_node_val;
    visited[start_node_val] = true;

    int time = -1;

    while (head != tail) {
        int level_size = tail - head;
        for (int i = 0; i < level_size; i++) {
            int u = queue[head++];

            AdjNode* curr = adj[u];
            while (curr) {
                int v = curr->val;
                if (!visited[v]) {
                    visited[v] = true;
                    queue[tail++] = v;
                }
                curr = curr->next;
            }
        }
        time++; 
    }
    return time;
}

int amountOfTime(struct TreeNode* root, int start) {
    for (int i = 0; i < MAX_NODES; i++) {
        adj[i] = NULL;
        visited[i] = false;
    }
    adj_pool_idx = 0;

    buildGraph(root, -1);

    return bfs(start);
}