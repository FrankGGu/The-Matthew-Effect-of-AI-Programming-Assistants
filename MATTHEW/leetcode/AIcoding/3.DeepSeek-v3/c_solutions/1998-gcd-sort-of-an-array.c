int parent[100001];

int find(int x) {
    if (parent[x] != x) {
        parent[x] = find(parent[x]);
    }
    return parent[x];
}

void unite(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX != rootY) {
        parent[rootY] = rootX;
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

bool gcdSort(int* nums, int numsSize) {
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxVal) maxVal = nums[i];
    }

    for (int i = 1; i <= maxVal; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        for (int factor = 2; factor * factor <= num; factor++) {
            if (num % factor == 0) {
                unite(nums[i], factor);
                unite(nums[i], num / factor);
            }
        }
    }

    int* sorted = (int*)malloc(numsSize * sizeof(int));
    memcpy(sorted, nums, numsSize * sizeof(int));

    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = 0; j < numsSize - i - 1; j++) {
            if (sorted[j] > sorted[j + 1]) {
                int temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (find(nums[i]) != find(sorted[i])) {
            free(sorted);
            return false;
        }
    }

    free(sorted);
    return true;
}