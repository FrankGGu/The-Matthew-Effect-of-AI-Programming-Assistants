#define MOD 1000000007
#define BASE 10000019

typedef struct {
    int *hashes;
    int size;
} HashSet;

HashSet* createHashSet(int size) {
    HashSet *set = (HashSet *)malloc(sizeof(HashSet));
    set->hashes = (int *)malloc(sizeof(int) * size);
    set->size = 0;
    return set;
}

void addHash(HashSet *set, int hash) {
    for (int i = 0; i < set->size; i++) {
        if (set->hashes[i] == hash) return;
    }
    set->hashes[set->size++] = hash;
}

int containsHash(HashSet *set, int hash) {
    for (int i = 0; i < set->size; i++) {
        if (set->hashes[i] == hash) return 1;
    }
    return 0;
}

void freeHashSet(HashSet *set) {
    free(set->hashes);
    free(set);
}

long long computeHash(int *path, int length) {
    long long hash = 0;
    for (int i = 0; i < length; i++) {
        hash = (hash * BASE + path[i]) % MOD;
    }
    return hash;
}

int dfs(struct TreeNode* root, int **paths, int *pathLength, HashSet *set, int length) {
    if (root == NULL) return 0;
    paths[length][0] = root->val;
    for (int i = 1; i < length; i++) {
        paths[length][i] = paths[length - 1][i - 1];
    }
    long long hash = computeHash(paths[length], length);
    addHash(set, hash);
    return dfs(root->left, paths, pathLength, set, length + 1) || dfs(root->right, paths, pathLength, set, length + 1);
}

int check(struct TreeNode* root, int *path, int pathSize) {
    HashSet *set = createHashSet(10000);
    int **paths = (int **)malloc(sizeof(int *) * pathSize);
    for (int i = 0; i < pathSize; i++) {
        paths[i] = (int *)malloc(sizeof(int) * (pathSize + 1));
    }
    dfs(root, paths, (int[]){0}, set, 0);
    for (int len = pathSize; len > 0; len--) {
        for (int start = 0; start <= pathSize - len; start++) {
            long long hash = computeHash(path + start, len);
            if (containsHash(set, hash)) {
                freeHashSet(set);
                for (int i = 0; i < pathSize; i++) {
                    free(paths[i]);
                }
                free(paths);
                return len;
            }
        }
    }
    freeHashSet(set);
    for (int i = 0; i < pathSize; i++) {
        free(paths[i]);
    }
    free(paths);
    return 0;
}

int longestCommonSubpath(int n, int **paths, int pathsSize, int *pathsColSize) {
    int maxLen = 0;
    for (int i = 0; i < pathsSize; i++) {
        maxLen = fmax(maxLen, check(paths[i], paths[i], pathsColSize[i]));
    }
    return maxLen;
}