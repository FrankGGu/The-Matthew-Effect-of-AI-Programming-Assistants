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
    TrieNode* curr = root;
    for (int i = 14; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (!curr->children[bit]) {
            curr->children[bit] = createNode();
        }
        curr = curr->children[bit];
        curr->count++;
    }
}

int countLessThan(TrieNode* root, int num, int limit) {
    TrieNode* curr = root;
    int count = 0;
    for (int i = 14; i >= 0 && curr; i--) {
        int numBit = (num >> i) & 1;
        int limitBit = (limit >> i) & 1;

        if (limitBit == 1) {
            if (curr->children[numBit]) {
                count += curr->children[numBit]->count;
            }
            curr = curr->children[1 - numBit];
        } else {
            curr = curr->children[numBit];
        }
    }
    return count;
}

int countPairs(int* nums, int numsSize, int low, int high) {
    TrieNode* root = createNode();
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += countLessThan(root, nums[i], high + 1) - countLessThan(root, nums[i], low);
        insert(root, nums[i]);
    }
    return res;
}