#include <stdlib.h>
#include <string.h>

#define MAX_NODES 100005
#define MAX_BITS 17 // Numbers up to 10^5. 2^16 = 65536, 2^17 = 131072. So 17 bits (0-16) are needed.

typedef struct TrieNode {
    struct TrieNode* children[2];
    int count; // Number of elements passing through this node
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->children[0] = NULL;
    node->children[1] = NULL;
    node->count = 0;
    return node;
}

void trieInsert(TrieNode* root, int num) {
    TrieNode* curr = root;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createTrieNode();
        }
        curr = curr->children[bit];
        curr->count++;
    }
}

void trieRemove(TrieNode* root, int num) {
    TrieNode* curr = root;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (num >> i) & 1;
        curr = curr->children[bit];
        curr->count--;
    }
}

int trieQueryMaxXor(TrieNode* root, int num) {
    TrieNode* curr = root;
    int maxXor = 0;
    for (int i = MAX_BITS - 1; i >= 0; i--) {
        int bit = (num >> i) & 1;
        int desiredBit = 1 - bit; // Try to go opposite to maximize XOR
        if (curr->children[desiredBit] != NULL && curr->children[desiredBit]->count > 0) {
            maxXor |= (1 << i);
            curr = curr->children[desiredBit];
        } else {
            // If the desired bit path is not available or empty, go with the same bit
            curr = curr->children[bit];
        }
    }
    return maxXor;
}

int* adj[MAX_NODES];
int adjSizes[MAX_NODES];
int adjCapacities[MAX_NODES];

typedef struct {
    int val;
    int index;
} QueryInfo;

QueryInfo* nodeQueries[MAX_NODES];
int nodeQueriesSizes[MAX_NODES];
int nodeQueriesCapacities[MAX_NODES];

TrieNode* trieRoot;

int* globalAnswers;

void addChild(int u, int v) {
    if (adjSizes[u] == adjCapacities[u]) {
        adjCapacities[u] = adjCapacities[u] == 0 ? 2 : adjCapacities[u] * 2;
        adj[u] = (int*)realloc(adj[u], sizeof(int) * adjCapacities[u]);
    }
    adj[u][adjSizes[u]++] = v;
}

void addNodeQuery(int node, int val, int index) {
    if (nodeQueriesSizes[node] == nodeQueriesCapacities[node]) {
        nodeQueriesCapacities[node] = nodeQueriesCapacities[node] == 0 ? 2 : nodeQueriesCapacities[node] * 2;
        nodeQueries[node] = (QueryInfo*)realloc(nodeQueries[node], sizeof(QueryInfo) * nodeQueriesCapacities[node]);
    }
    nodeQueries[node][nodeQueriesSizes[node]].val = val;
    nodeQueries[node][nodeQueriesSizes[node]].index = index;
    nodeQueriesSizes[node]++;
}

void dfs(int u, int* nums) {
    // 1. Add current node's value to the Trie
    trieInsert(trieRoot, nums[u]);

    // 2. Process all queries associated with the current node
    for (int i = 0; i < nodeQueriesSizes[u]; i++) {
        globalAnswers[nodeQueries[u][i].index] = trieQueryMaxXor(trieRoot, nodeQueries[u][i].val);
    }

    // 3. Recursively call DFS for all children
    for (int i = 0; i < adjSizes[u]; i++) {
        int v = adj[u][i]; // v is a child of u
        dfs(v, nums);
    }

    // 4. Remove current node's value from the Trie (backtrack)
    trieRemove(trieRoot, nums[u]);
}

void freeTrieRecursive(TrieNode* node) {
    if (!node) return;
    freeTrieRecursive(node->children[0]);
    freeTrieRecursive(node->children[1]);
    free(node);
}

int* maxGeneticDifference(int* parents, int parentsSize, int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // Initialize global arrays for adjacency list and node queries
    memset(adjSizes, 0, sizeof(int) * numsSize);
    memset(adjCapacities, 0, sizeof(int) * numsSize);
    memset(nodeQueriesSizes, 0, sizeof(int) * numsSize);
    memset(nodeQueriesCapacities, 0, sizeof(int) * numsSize);

    for (int i = 0; i < numsSize; i++) {
        adj[i] = NULL; // Initialize pointers to NULL
        nodeQueries[i] = NULL;
    }

    // Build adjacency list (only children for each node)
    int rootNode = -1;
    for (int i = 0; i < parentsSize; i++) {
        if (parents[i] == -1) {
            rootNode = i; // Found the root node
        } else {
            addChild(parents[i], i); // parents[i] is the parent of i, so i is a child of parents[i]
        }
    }

    // Group queries by node
    globalAnswers = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;
    for (int i = 0; i < queriesSize; i++) {
        int node = queries[i][0];
        int val = queries[i][1];
        addNodeQuery(node, val, i);
    }

    // Initialize the Trie
    trieRoot = createTrieNode();

    // Perform DFS starting from the root node
    dfs(rootNode, nums);

    // Clean up allocated memory for adjacency list and node queries
    for (int i = 0; i < numsSize; i++) {
        free(adj[i]);
        free(nodeQueries[i]);
    }
    freeTrieRecursive(trieRoot); // Free all Trie nodes

    return globalAnswers; // The caller is responsible for freeing this array
}