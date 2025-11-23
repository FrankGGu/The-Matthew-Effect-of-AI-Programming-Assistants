typedef struct {
    char *key;
    struct TreeNode *node;
    UT_hash_handle hh;
} HashNode;

char* serialize(struct TreeNode* root, HashNode** map, int* id, struct TreeNode*** res, int* returnSize) {
    if (root == NULL) return "#";

    char left[10000];
    char right[10000];

    sprintf(left, "%s", serialize(root->left, map, id, res, returnSize));
    sprintf(right, "%s", serialize(root->right, map, id, res, returnSize));

    char *key = (char*)malloc(sizeof(char) * 10000);
    sprintf(key, "%d,%s,%s", root->val, left, right);

    HashNode *entry = NULL;
    HASH_FIND_STR(*map, key, entry);

    if (entry == NULL) {
        entry = (HashNode*)malloc(sizeof(HashNode));
        entry->key = key;
        entry->node = root;
        entry->node->val = *id;
        (*id)++;
        HASH_ADD_STR(*map, key, entry);
    } else {
        free(key);
        if (entry->node->val >= 0) {
            *res = (struct TreeNode**)realloc(*res, sizeof(struct TreeNode*) * (*returnSize + 1));
            (*res)[*returnSize] = root;
            (*returnSize)++;
            entry->node->val = -1;
        }
    }

    return entry->key;
}

struct TreeNode** findDuplicateSubtrees(struct TreeNode* root, int* returnSize) {
    HashNode *map = NULL;
    *returnSize = 0;
    struct TreeNode** res = NULL;
    int id = 0;

    serialize(root, &map, &id, &res, returnSize);

    HashNode *current, *tmp;
    HASH_ITER(hh, map, current, tmp) {
        HASH_DEL(map, current);
        free(current->key);
        free(current);
    }

    return res;
}