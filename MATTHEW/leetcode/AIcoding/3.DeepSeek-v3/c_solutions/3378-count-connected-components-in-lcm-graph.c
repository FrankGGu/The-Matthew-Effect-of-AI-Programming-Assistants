int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unite(int* parent, int* rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

int countComponents(int* nums, int numsSize, int threshold) {
    if (numsSize == 0) return 0;

    int max_num = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_num) max_num = nums[i];
    }

    int* parent = (int*)malloc((max_num + 1) * sizeof(int));
    int* rank = (int*)malloc((max_num + 1) * sizeof(int));
    for (int i = 0; i <= max_num; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int* present = (int*)calloc(max_num + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        present[nums[i]] = 1;
    }

    for (int k = threshold + 1; k <= max_num; k++) {
        int first = -1;
        for (int multiple = k; multiple <= max_num; multiple += k) {
            if (present[multiple]) {
                if (first == -1) {
                    first = multiple;
                } else {
                    unite(parent, rank, first, multiple);
                }
            }
        }
    }

    int components = 0;
    for (int i = 0; i < numsSize; i++) {
        if (find(parent, nums[i]) == nums[i]) {
            components++;
        }
    }

    free(parent);
    free(rank);
    free(present);
    return components;
}