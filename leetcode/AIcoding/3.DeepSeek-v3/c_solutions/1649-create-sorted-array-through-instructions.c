int tree[100002];

void update(int idx, int n) {
    while (idx <= n) {
        tree[idx]++;
        idx += idx & -idx;
    }
}

int query(int idx) {
    int sum = 0;
    while (idx > 0) {
        sum += tree[idx];
        idx -= idx & -idx;
    }
    return sum;
}

int createSortedArray(int* instructions, int instructionsSize) {
    int max_val = 0;
    for (int i = 0; i < instructionsSize; i++) {
        if (instructions[i] > max_val) max_val = instructions[i];
    }

    for (int i = 0; i <= max_val + 1; i++) tree[i] = 0;

    long long cost = 0;
    int mod = 1e9 + 7;

    for (int i = 0; i < instructionsSize; i++) {
        int num = instructions[i];
        int less = query(num - 1);
        int greater = i - query(num);
        cost += less < greater ? less : greater;
        update(num, max_val);
    }

    return cost % mod;
}