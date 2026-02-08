int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int* parent, int* rank, int x, int y) {
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

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool canTraverseAllPairs(int* nums, int numsSize) {
    if (numsSize == 1) return true;

    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) max_val = nums[i];
        if (nums[i] == 1) return false;
    }

    int* parent = (int*)malloc((max_val + 1) * sizeof(int));
    int* rank = (int*)calloc((max_val + 1), sizeof(int));
    for (int i = 0; i <= max_val; i++) {
        parent[i] = i;
    }

    int* spf = (int*)malloc((max_val + 1) * sizeof(int));
    for (int i = 0; i <= max_val; i++) {
        spf[i] = i;
    }

    for (int i = 2; i * i <= max_val; i++) {
        if (spf[i] == i) {
            for (int j = i * i; j <= max_val; j += i) {
                if (spf[j] == j) {
                    spf[j] = i;
                }
            }
        }
    }

    for (int i = 0; i < numsSize; i++) {
        int x = nums[i];
        int temp = x;
        while (temp > 1) {
            int p = spf[temp];
            unionSets(parent, rank, x, p);
            while (temp % p == 0) {
                temp /= p;
            }
        }
    }

    int root = find(parent, nums[0]);
    for (int i = 1; i < numsSize; i++) {
        if (find(parent, nums[i]) != root) {
            free(parent);
            free(rank);
            free(spf);
            return false;
        }
    }

    free(parent);
    free(rank);
    free(spf);
    return true;
}