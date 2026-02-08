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
        if (node->children[bit] == NULL) {
            node->children[bit] = createNode();
        }
        node = node->children[bit];
    }
}

int findMaximumXOR(int* nums, int numsSize) {
    TrieNode* root = createNode();
    for (int i = 0; i < numsSize; i++) {
        insert(root, nums[i]);
    }

    int max_xor = 0;
    for (int i = 0; i < numsSize; i++) {
        TrieNode* node = root;
        int curr_xor = 0;
        for (int j = 31; j >= 0; j--) {
            int bit = (nums[i] >> j) & 1;
            int target_bit = 1 - bit;
            if (node->children[target_bit] != NULL) {
                curr_xor |= (1 << j);
                node = node->children[target_bit];
            } else {
                node = node->children[bit];
            }
        }
        if (curr_xor > max_xor) {
            max_xor = curr_xor;
        }
    }

    return max_xor;
}