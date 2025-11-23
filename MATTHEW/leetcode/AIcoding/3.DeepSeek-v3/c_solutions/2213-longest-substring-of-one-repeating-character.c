typedef struct {
    int left;
    int right;
    int prefix;
    int suffix;
    int max;
    char leftChar;
    char rightChar;
} Node;

Node tree[80000];

Node merge(Node l, Node r) {
    Node res;
    res.left = l.left;
    res.right = r.right;
    res.leftChar = l.leftChar;
    res.rightChar = r.rightChar;

    res.max = (l.max > r.max) ? l.max : r.max;
    if (l.rightChar == r.leftChar) {
        int len = l.suffix + r.prefix;
        if (len > res.max) res.max = len;
    }

    res.prefix = l.prefix;
    if (l.prefix == (l.right - l.left + 1) && l.rightChar == r.leftChar) {
        res.prefix = l.prefix + r.prefix;
    }

    res.suffix = r.suffix;
    if (r.suffix == (r.right - r.left + 1) && l.rightChar == r.leftChar) {
        res.suffix = r.suffix + l.suffix;
    }

    return res;
}

void build(int idx, int l, int r, char *s) {
    if (l == r) {
        tree[idx].left = l;
        tree[idx].right = r;
        tree[idx].prefix = 1;
        tree[idx].suffix = 1;
        tree[idx].max = 1;
        tree[idx].leftChar = s[l];
        tree[idx].rightChar = s[l];
        return;
    }
    int mid = (l + r) / 2;
    build(2 * idx + 1, l, mid, s);
    build(2 * idx + 2, mid + 1, r, s);
    tree[idx] = merge(tree[2 * idx + 1], tree[2 * idx + 2]);
}

void update(int idx, int pos, char c) {
    if (tree[idx].left == tree[idx].right) {
        tree[idx].leftChar = c;
        tree[idx].rightChar = c;
        return;
    }
    int mid = (tree[idx].left + tree[idx].right) / 2;
    if (pos <= mid) {
        update(2 * idx + 1, pos, c);
    } else {
        update(2 * idx + 2, pos, c);
    }
    tree[idx] = merge(tree[2 * idx + 1], tree[2 * idx + 2]);
}

int* longestRepeating(char* s, char* queryCharacters, int* queryIndices, int queryIndicesSize, int* returnSize) {
    int n = strlen(s);
    build(0, 0, n - 1, s);

    int *res = (int*)malloc(queryIndicesSize * sizeof(int));
    *returnSize = queryIndicesSize;

    for (int i = 0; i < queryIndicesSize; i++) {
        update(0, queryIndices[i], queryCharacters[i]);
        res[i] = tree[0].max;
    }

    return res;
}