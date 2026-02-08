typedef struct TrieNode {
    struct TrieNode* children[10];
    int count;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 10; i++) {
        node->children[i] = NULL;
    }
    node->count = 0;
    return node;
}

void insert(TrieNode* root, int num) {
    TrieNode* node = root;
    char str[20];
    sprintf(str, "%d", num);
    for (int i = 0; str[i]; i++) {
        int digit = str[i] - '0';
        if (!node->children[digit]) {
            node->children[digit] = createNode();
        }
        node = node->children[digit];
        node->count++;
    }
}

int longestCommonPrefix(int* arr1, int arr1Size, int* arr2, int arr2Size) {
    TrieNode* root = createNode();

    for (int i = 0; i < arr1Size; i++) {
        insert(root, arr1[i]);
    }

    int maxLen = 0;
    for (int i = 0; i < arr2Size; i++) {
        TrieNode* node = root;
        char str[20];
        sprintf(str, "%d", arr2[i]);
        int len = 0;
        for (int j = 0; str[j]; j++) {
            int digit = str[j] - '0';
            if (node->children[digit]) {
                node = node->children[digit];
                len++;
            } else {
                break;
            }
        }
        if (len > maxLen) {
            maxLen = len;
        }
    }

    return maxLen;
}