#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int* data;
    int size;
} Result;

TreeNode* createTreeNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

int* smallestMissingGeneticValueEachSubtree(TreeNode* root, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 100001);
    for (int i = 0; i < 100001; ++i) {
        result[i] = 0;
    }

    int* parent = (int*)malloc(sizeof(int) * 100001);
    int* visited = (int*)malloc(sizeof(int) * 100001);
    int* gene = (int*)malloc(sizeof(int) * 100001);

    for (int i = 0; i < 100001; ++i) {
        parent[i] = -1;
        visited[i] = 0;
        gene[i] = 0;
    }

    int geneCount = 0;

    void dfs(TreeNode* node) {
        if (!node) return;
        gene[node->val] = 1;
        geneCount++;
        if (node->left) {
            parent[node->left->val] = node->val;
            dfs(node->left);
        }
        if (node->right) {
            parent[node->right->val] = node->val;
            dfs(node->right);
        }
    }

    dfs(root);

    int missing = 1;
    while (gene[missing]) {
        missing++;
    }

    int* subtreeGene = (int*)malloc(sizeof(int) * 100001);
    for (int i = 0; i < 100001; ++i) {
        subtreeGene[i] = 0;
    }

    void dfs2(TreeNode* node) {
        if (!node) return;
        subtreeGene[node->val] = 1;
        if (node->left) dfs2(node->left);
        if (node->right) dfs2(node->right);
    }

    for (int i = 0; i < 100001; ++i) {
        if (gene[i]) {
            dfs2(root);
            int current = 1;
            while (subtreeGene[current]) {
                current++;
            }
            result[i] = current;
            for (int j = 0; j < 100001; ++j) {
                subtreeGene[j] = 0;
            }
        }
    }

    *returnSize = 100001;
    return result;
}