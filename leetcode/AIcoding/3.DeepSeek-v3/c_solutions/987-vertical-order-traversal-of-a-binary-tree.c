typedef struct {
    int row;
    int col;
    int val;
} NodeInfo;

typedef struct {
    NodeInfo* data;
    int size;
    int capacity;
} List;

void initList(List* list) {
    list->data = malloc(1000 * sizeof(NodeInfo));
    list->size = 0;
    list->capacity = 1000;
}

void appendList(List* list, int row, int col, int val) {
    if (list->size == list->capacity) {
        list->capacity *= 2;
        list->data = realloc(list->data, list->capacity * sizeof(NodeInfo));
    }
    list->data[list->size].row = row;
    list->data[list->size].col = col;
    list->data[list->size].val = val;
    list->size++;
}

int compare(const void* a, const void* b) {
    NodeInfo* na = (NodeInfo*)a;
    NodeInfo* nb = (NodeInfo*)b;

    if (na->col != nb->col) {
        return na->col - nb->col;
    }
    if (na->row != nb->row) {
        return na->row - nb->row;
    }
    return na->val - nb->val;
}

void dfs(struct TreeNode* root, int row, int col, List* list) {
    if (root == NULL) return;

    appendList(list, row, col, root->val);
    dfs(root->left, row + 1, col - 1, list);
    dfs(root->right, row + 1, col + 1, list);
}

int** verticalTraversal(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    List list;
    initList(&list);
    dfs(root, 0, 0, &list);

    qsort(list.data, list.size, sizeof(NodeInfo), compare);

    int** result = malloc(list.size * sizeof(int*));
    *returnColumnSizes = malloc(list.size * sizeof(int));
    *returnSize = 0;

    int idx = 0;
    while (idx < list.size) {
        int currentCol = list.data[idx].col;
        int start = idx;

        while (idx < list.size && list.data[idx].col == currentCol) {
            idx++;
        }

        int colSize = idx - start;
        result[*returnSize] = malloc(colSize * sizeof(int));
        (*returnColumnSizes)[*returnSize] = colSize;

        for (int i = 0; i < colSize; i++) {
            result[*returnSize][i] = list.data[start + i].val;
        }

        (*returnSize)++;
    }

    free(list.data);
    return result;
}