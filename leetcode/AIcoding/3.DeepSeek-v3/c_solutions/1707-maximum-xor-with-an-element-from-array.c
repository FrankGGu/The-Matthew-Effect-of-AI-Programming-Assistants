/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

typedef struct TrieNode {
    struct TrieNode* children[2];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->children[0] = NULL;
    node->children[1] = NULL;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* node = root;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (!node->children[bit]) {
            node->children[bit] = createNode();
        }
        node = node->children[bit];
    }
}

int findMaxXOR(TrieNode* root, int num) {
    if (!root) return -1;
    TrieNode* node = root;
    int res = 0;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        int desired = 1 - bit;
        if (node->children[desired]) {
            res |= (1 << i);
            node = node->children[desired];
        } else {
            node = node->children[bit];
        }
    }
    return res;
}

void freeTrie(TrieNode* root) {
    if (!root) return;
    freeTrie(root->children[0]);
    freeTrie(root->children[1]);
    free(root);
}

int cmp(const void* a, const void* b) {
    return ((*(int**)a)[0] - (*(int**)b)[0]);
}

int* maximizeXor(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int** sortedQueries = (int**)malloc(queriesSize * sizeof(int*));
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i] = (int*)malloc(3 * sizeof(int));
        sortedQueries[i][0] = queries[i][1];
        sortedQueries[i][1] = queries[i][0];
        sortedQueries[i][2] = i;
    }

    qsort(sortedQueries, queriesSize, sizeof(int*), cmp);
    qsort(nums, numsSize, sizeof(int), cmp);

    int* res = (int*)malloc(queriesSize * sizeof(int));
    TrieNode* root = createNode();
    int idx = 0;

    for (int i = 0; i < queriesSize; i++) {
        int m = sortedQueries[i][0];
        int x = sortedQueries[i][1];
        int origIdx = sortedQueries[i][2];

        while (idx < numsSize && nums[idx] <= m) {
            insert(root, nums[idx]);
            idx++;
        }

        res[origIdx] = findMaxXOR(root, x);
    }

    for (int i = 0; i < queriesSize; i++) {
        free(sortedQueries[i]);
    }
    free(sortedQueries);
    freeTrie(root);

    *returnSize = queriesSize;
    return res;
}