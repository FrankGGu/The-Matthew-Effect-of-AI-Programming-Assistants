long long count[101];
long long MOD = 1e9 + 7;

int threeSumMulti(int* arr, int arrSize, int target) {
    for (int i = 0; i <= 100; i++) {
        count[i] = 0;
    }

    for (int i = 0; i < arrSize; i++) {
        count[arr[i]]++;
    }

    long long ans = 0;

    for (int x = 0; x <= 100; x++) {
        if (count[x] == 0) continue;

        for (int y = x; y <= 100; y++) {
            if (count[y] == 0) continue;

            int z = target - x - y;

            if (z < y || z > 100) {
                continue;
            }
            if (count[z] == 0) continue;

            if (x == y && y == z) {
                ans = (ans + count[x] * (count[x] - 1) * (count[x] - 2) / 6) % MOD;
            } else if (x == y && y != z) {
                ans = (ans + count[x] * (count[x] - 1) / 2 * count[z]) % MOD;
            } else if (x != y && y == z) {
                ans = (ans + count[x] * count[y] * (count[y] - 1) / 2) % MOD;
            } else { // x < y < z
                ans = (ans + count[x] * count[y] * count[z]) % MOD;
            }
        }
    }

    return (int)ans;
}