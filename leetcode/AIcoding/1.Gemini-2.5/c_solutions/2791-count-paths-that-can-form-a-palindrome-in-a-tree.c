#include <stdlib.h>
#include <string.h> // For memset (though not strictly needed with explicit init)

typedef struct AdjNode {
    int dest;
    struct AdjNode* next;
} AdjNode;

typedef struct {
    AdjNode* head;
} AdjList;

AdjList* graph_global;
char* S_global; // To access S from DFS
long long total_paths_global;

#define HASH_TABLE_SIZE 200003 // A prime number, roughly 2*N for N=10^5

typedef struct HashMapNode {
    int key;
    int value;
    struct HashMapNode* next;
} HashMapNode;

HashMapNode* hash_table_global[HASH_TABLE_SIZE];
#define MAX_HASH_NODES 100005 // Max N + a few extra for safety
HashMapNode hash_node_pool[MAX_HASH_NODES];
int hash_node_pool_idx;

void hash_map_init() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        hash_table_global[i] = NULL;
    }
    hash_node_pool_idx = 0;
}

HashMapNode* get_new_hash_node(int key, int value) {
    if (hash_node_pool_idx >= MAX_HASH_NODES) {
        // This case indicates an issue with MAX_HASH_NODES or problem constraints.
        // For LeetCode, assume MAX_HASH_NODES is sufficient.
        return NULL; 
    }
    HashMapNode* node = &hash_node_pool[hash_node_pool_idx++];
    node->key = key;
    node->value = value;
    node->next = NULL;
    return node;
}

void hash_map_put(int key, int value) {
    unsigned int index = (unsigned int)key % HASH_TABLE_SIZE;
    HashMapNode* current = hash_table_global[index];
    while (current != NULL) {
        if (current->key == key) {
            current->value = value;
            return;
        }
        current = current->next;
    }
    // Key not found, add new node from pool
    HashMapNode* new_node = get_new_hash_node(key, value);
    if (new_node) {
        new_node->next = hash_table_global[index];
        hash_table_global[index] = new_node;
    }
}

int hash_map_get(int key) {
    unsigned int index = (unsigned int)key % HASH_TABLE_SIZE;
    HashMapNode* current = hash_table_global[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->value;
        }
        current = current->next;
    }
    return 0; // Key not found, default value is 0
}

void dfs(int u, int p, int current_mask) {
    // Update mask for current node u based on its character
    current_mask ^= (1 << (S_global[u] - 'a'));

    // Count paths ending at u
    // Case 1: mask(v, u) = 0
    // This means mask(root, v) == mask(root, u).
    // hash_map_get(current_mask) returns the count of nodes 'v' (including 'u' itself
    // if its mask was already added) whose path mask from root matches current_mask.
    // Each such 'v' forms a path (v, u) with mask 0.
    total_paths_global += hash_map_get(current_mask);

    // Case 2: mask(v, u) = (1 << i) for some i (0 to 25)
    // This means mask(root, v) == mask(root, u) ^ (1 << i).
    // Each such 'v' forms a path (v, u) with mask (1 << i).
    for (int i = 0; i < 26; i++) {
        total_paths_global += hash_map_get(current_mask ^ (1 << i));
    }

    // Add current_mask to hash map for future descendants/nodes.
    // This must be done AFTER counting for 'u' itself, but BEFORE recursing to children.
    // The current node 'u' is now available for its children or later nodes in the DFS.
    hash_map_put(current_mask, hash_map_get(current_mask) + 1);

    // Recurse for children
    AdjNode* node = graph_global[u].head;
    while (node != NULL) {
        int v = node->dest;
        if (v != p) {
            dfs(v, u, current_mask);
        }
        node = node->next;
    }
}

long long countPalindromePaths(int n, int* parent, int parentSize, char* s) {
    S_global = s;
    total_paths_global = 0;

    // Build adjacency list
    graph_global = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        graph_global[i].head = NULL;
    }

    // Adjacency list node memory pool
    // Max edges = N-1. Each edge creates 2 AdjNodes. So 2*(N-1) AdjNodes.
    // Handle n=1 case where n-1 = 0.
    AdjNode* adj_node_pool = NULL;
    int adj_node_pool_idx = 0;
    if (n > 1) {
        adj_node_pool = (AdjNode*)malloc(2 * (n - 1) * sizeof(AdjNode));
    }

    for (int i = 1; i < n; i++) { // Node 0 is root, parent[0] is -1
        int u = parent[i];
        int v = i;

        // Add edge u-v
        // Assuming adj_node_pool is not NULL here (i.e., n > 1)
        AdjNode* newNode1 = &adj_node_pool[adj_node_pool_idx++];
        newNode1->dest = v;
        newNode1->next = graph_global[u].head;
        graph_global[u].head = newNode1;

        AdjNode* newNode2 = &adj_node_pool[adj_node_pool_idx++];
        newNode2->dest = u;
        newNode2->next = graph_global[v].head;
        graph_global[v].head = newNode2;
    }

    hash_map_init();
    // Start DFS from root (node 0), parent -1, initial mask 0.
    // The initial mask of 0 represents the state before processing node 0.
    // Node 0's mask will be calculated in DFS and added to the map.
    dfs(0, -1, 0); 

    // Free graph memory
    free(graph_global);
    if (adj_node_pool) {
        free(adj_node_pool);
    }
    // hash_node_pool is static, no need to free.

    return total_paths_global;
}