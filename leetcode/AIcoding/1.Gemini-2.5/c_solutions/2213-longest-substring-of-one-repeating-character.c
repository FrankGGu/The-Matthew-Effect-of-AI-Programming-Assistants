#include <stdlib.h>
#include <string.h>

typedef struct {
    int len;
    char prefix_char;
    int prefix_len;
    char suffix_char;
    int suffix_len;
    int max_len;
} Node;

Node* tree;
char* s_arr;

int max(int a, int b) {
    return a > b ? a : b;
}

void merge(Node* parent, const Node* left, const Node* right) {
    parent->len = left->len + right->len;

    parent->prefix_char = left->prefix_char;
    parent->prefix_len = left->prefix_len;
    if (left->prefix_len == left->len && left->prefix_char == right->prefix_char) {
        parent->prefix_len += right->prefix_len;
    }

    parent->suffix_char = right->suffix_char;
    parent->suffix_len = right->suffix_len;
    if (right->suffix_len == right->len && right->suffix_char == left->suffix_char) {
        parent->suffix_len += left->suffix_len;
    }

    parent->max_len = max(left->max_len, right->max_len);
    if (left->suffix_char == right->prefix_char) {
        parent->max_len = max(parent->max_len, left->suffix_len + right->prefix_len);
    }
}

void build(int node_idx, int start, int end) {
    if (start == end) {
        tree[node_idx].len = 1;
        tree[node_idx].prefix_char = s_arr[start];
        tree[node_idx].prefix_len = 1;
        tree[node_idx].suffix_char = s_arr[start];
        tree[node_idx].suffix_len = 1;
        tree[node_idx].max_len = 1;
    } else {
        int mid = start + (end - start) / 2;
        build(2 * node_idx, start, mid);
        build(2 * node_idx + 1, mid + 1, end);
        merge(&tree[node_idx], &tree[2 * node_idx], &tree[2 * node_idx + 1]);
    }
}

void update(int node_idx, int start, int end, int idx, char val) {
    if (start == end) {
        s_arr[idx] = val;
        tree[node_idx].prefix_char = val;
        tree[node_idx].suffix_char = val;
    } else {
        int mid = start + (end - start) / 2;
        if (start <= idx && idx <= mid) {
            update(2 * node_idx, start, mid, idx, val);
        } else {
            update(2 * node_idx + 1, mid + 1, end, idx, val);
        }
        merge(&tree[node_idx], &tree[2 * node_idx], &tree[2 * node_idx + 1]);
    }
}

int* longestRepeatingSubstring(char* s, char* queryCharacters, int* queryIndices, int queriesSize, int* returnSize) {
    int n = strlen(s);
    s_arr = s;

    tree = (Node*)malloc(4 * n * sizeof(Node));
    if (tree == NULL) {
        *returnSize = 0;
        return NULL;
    }

    if (n > 0) { // Handle empty string case for build
        build(1, 0, n - 1);
    } else { // If s is empty, all results will be 0.
        // Initialize tree[1] to represent an empty string
        tree[1].len = 0;
        tree[1].prefix_char = '\0'; // Or any non-valid char
        tree[1].prefix_len = 0;
        tree[1].suffix_char = '\0';
        tree[1].suffix_len = 0;
        tree[1].max_len = 0;
    }

    int* results = (int*)malloc(queriesSize * sizeof(int));
    if (results == NULL) {
        free(tree);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < queriesSize; ++i) {
        int idx = queryIndices[i];
        char val = queryCharacters[i];

        if (n == 0) { // If original string was empty, all updates effectively create a string of length 1
            results[i] = 1;
        } else {
            update(1, 0, n - 1, idx, val);
            results[i] = tree[1].max_len;
        }
    }

    free(tree);
    *returnSize = queriesSize;
    return results;
}