typedef struct {
    int size;
    int *tree;
} FenwickTree;

FenwickTree* createFenwickTree(int n) {
    FenwickTree* ft = (FenwickTree*)malloc(sizeof(FenwickTree));
    ft->size = n + 1;
    ft->tree = (int*)calloc(ft->size, sizeof(int));
    return ft;
}

void update(FenwickTree* ft, int index, int delta) {
    while (index < ft->size) {
        ft->tree[index] += delta;
        index += index & -index;
    }
}

int query(FenwickTree* ft, int index) {
    int sum = 0;
    while (index > 0) {
        sum += ft->tree[index];
        index -= index & -index;
    }
    return sum;
}

long long goodTriplets(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int n = nums1Size;
    int* pos2 = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        pos2[nums2[i]] = i;
    }

    int* mapped = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        mapped[i] = pos2[nums1[i]] + 1;
    }

    FenwickTree* ft_left = createFenwickTree(n);
    long long* left = (long long*)malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) {
        left[i] = query(ft_left, mapped[i] - 1);
        update(ft_left, mapped[i], 1);
    }

    FenwickTree* ft_right = createFenwickTree(n);
    long long* right = (long long*)malloc(n * sizeof(long long));
    for (int i = n - 1; i >= 0; i--) {
        right[i] = query(ft_right, n) - query(ft_right, mapped[i]);
        update(ft_right, mapped[i], 1);
    }

    long long result = 0;
    for (int i = 0; i < n; i++) {
        result += left[i] * right[i];
    }

    free(pos2);
    free(mapped);
    free(left);
    free(right);
    free(ft_left->tree);
    free(ft_left);
    free(ft_right->tree);
    free(ft_right);

    return result;
}