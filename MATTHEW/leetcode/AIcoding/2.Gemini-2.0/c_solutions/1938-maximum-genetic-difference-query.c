#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[2];
    int val;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->children[0] = NULL;
    node->children[1] = NULL;
    node->val = -1;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* curr = root;
    for (int i = 19; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createNode();
        }
        curr = curr->children[bit];
    }
    curr->val = num;
}

void removeNode(TrieNode* root, int num) {
    TrieNode* curr = root;
    TrieNode* path[20];
    int bits[20];

    for (int i = 19; i >= 0; i--) {
        int bit = (num >> i) & 1;
        path[19 - i] = curr;
        bits[19 - i] = bit;
        curr = curr->children[bit];
    }

    curr->val = -1;

    for (int i = 0; i < 20; i++) {
        int bit = bits[i];
        TrieNode* parent = path[i];
        if (parent->children[bit]->children[0] == NULL && parent->children[bit]->children[1] == NULL) {
            free(parent->children[bit]);
            parent->children[bit] = NULL;
        } else {
            break;
        }
    }
}

int findMaxXor(TrieNode* root, int num) {
    TrieNode* curr = root;
    if (curr == NULL) return -1;

    for (int i = 19; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[1 - bit] != NULL) {
            curr = curr->children[1 - bit];
        } else {
            curr = curr->children[bit];
        }
    }
    return num ^ curr->val;
}

int* maxGeneticDifference(int* parents, int parentsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = parentsSize;
    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    int* adj[n];
    int adjSize[n];
    for (int i = 0; i < n; i++) {
        adjSize[i] = 0;
        adj[i] = (int*)malloc(sizeof(int) * n);
    }

    int root = -1;
    for (int i = 0; i < n; i++) {
        if (parents[i] == -1) {
            root = i;
        } else {
            adj[parents[i]][adjSize[parents[i]]++] = i;
        }
    }

    int* queryIndices[n];
    int queryIndicesSize[n];
    for (int i = 0; i < n; i++) {
        queryIndicesSize[i] = 0;
        queryIndices[i] = (int*)malloc(sizeof(int) * queriesSize);
    }

    for (int i = 0; i < queriesSize; i++) {
        queryIndices[queries[i][0]][queryIndicesSize[queries[i][0]]++] = i;
    }

    TrieNode* trieRoot = createNode();

    void dfs(int node) {
        insert(trieRoot, node);

        for (int i = 0; i < queryIndicesSize[node]; i++) {
            int queryIndex = queryIndices[node][i];
            ans[queryIndex] = findMaxXor(trieRoot, queries[queryIndex][1]);
        }

        for (int i = 0; i < adjSize[node]; i++) {
            dfs(adj[node][i]);
        }

        removeNode(trieRoot, node);
    }

    dfs(root);

    for (int i = 0; i < n; i++) {
        free(adj[i]);
        free(queryIndices[i]);
    }

    return ans;
}