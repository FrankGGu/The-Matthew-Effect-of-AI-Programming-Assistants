typedef struct {
    int* data;
    int size;
    int capacity;
} Array;

Array* createArray() {
    Array* arr = (Array*)malloc(sizeof(Array));
    arr->data = (int*)malloc(sizeof(int) * 16);
    arr->size = 0;
    arr->capacity = 16;
    return arr;
}

void push(Array* arr, int val) {
    if (arr->size == arr->capacity) {
        arr->capacity *= 2;
        arr->data = (int*)realloc(arr->data, sizeof(int) * arr->capacity);
    }
    arr->data[arr->size++] = val;
}

void freeArray(Array* arr) {
    free(arr->data);
    free(arr);
}

typedef struct TrieNode {
    struct TrieNode* children[201];
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 201; i++) {
        node->children[i] = NULL;
    }
    return node;
}

int countDistinct(int* nums, int numsSize, int k, int p) {
    TrieNode* root = createTrieNode();
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        TrieNode* node = root;
        int divisibleCount = 0;

        for (int j = i; j < numsSize; j++) {
            if (nums[j] % p == 0) {
                divisibleCount++;
            }
            if (divisibleCount > k) {
                break;
            }

            if (node->children[nums[j]] == NULL) {
                node->children[nums[j]] = createTrieNode();
                count++;
            }
            node = node->children[nums[j]];
        }
    }

    return count;
}