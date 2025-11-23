typedef struct TrieNode {
    struct TrieNode* children[2];
    int count;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->children[0] = NULL;
    node->children[1] = NULL;
    node->count = 0;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* node = root;
    for (int i = 19; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (node->children[bit] == NULL) {
            node->children[bit] = createNode();
        }
        node = node->children[bit];
        node->count++;
    }
}

void removeNum(TrieNode* root, int num) {
    TrieNode* node = root;
    for (int i = 19; i >= 0; i--) {
        int bit = (num >> i) & 1;
        node = node->children[bit];
        node->count--;
    }
}

int query(TrieNode* root, int num) {
    TrieNode* node = root;
    int res = 0;
    for (int i = 19; i >= 0; i--) {
        int bit = (num >> i) & 1;
        int desired = 1 - bit;
        if (node->children[desired] != NULL && node->children[desired]->count > 0) {
            res |= (1 << i);
            node = node->children[desired];
        } else {
            node = node->children[bit];
        }
    }
    return res;
}

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int maximumStrongPairXor(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    TrieNode* root = createNode();
    int j = 0;
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        while (j < numsSize && nums[j] <= 2 * nums[i]) {
            insert(root, nums[j]);
            j++;
        }
        res = fmax(res, query(root, nums[i]));
        removeNum(root, nums[i]);
    }
    return res;
}