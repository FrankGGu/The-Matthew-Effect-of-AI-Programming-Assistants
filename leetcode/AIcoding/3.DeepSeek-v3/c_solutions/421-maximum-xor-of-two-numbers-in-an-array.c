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
    TrieNode* curr = root;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (curr->children[bit] == NULL) {
            curr->children[bit] = createNode();
        }
        curr = curr->children[bit];
    }
}

int findMaxXOR(TrieNode* root, int num) {
    TrieNode* curr = root;
    int maxXOR = 0;
    for (int i = 31; i >= 0; i--) {
        int bit = (num >> i) & 1;
        int toggleBit = 1 - bit;
        if (curr->children[toggleBit] != NULL) {
            maxXOR |= (1 << i);
            curr = curr->children[toggleBit];
        } else {
            curr = curr->children[bit];
        }
    }
    return maxXOR;
}

int findMaximumXOR(int* nums, int numsSize) {
    if (numsSize == 0 || numsSize == 1) return 0;

    TrieNode* root = createNode();
    for (int i = 0; i < numsSize; i++) {
        insert(root, nums[i]);
    }

    int maxResult = 0;
    for (int i = 0; i < numsSize; i++) {
        int currentMax = findMaxXOR(root, nums[i]);
        if (currentMax > maxResult) {
            maxResult = currentMax;
        }
    }

    return maxResult;
}