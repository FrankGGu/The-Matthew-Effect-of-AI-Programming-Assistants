int countSubsequences(int* nums, int numsSize) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int* gcd_count = (int*)calloc(max_val + 1, sizeof(int));
    int mod = 1000000007;

    for (int i = 0; i < numsSize; i++) {
        int x = nums[i];
        int* temp = (int*)calloc(max_val + 1, sizeof(int));

        for (int g = 1; g <= max_val; g++) {
            if (gcd_count[g] == 0) continue;

            int new_gcd = gcd(g, x);
            temp[new_gcd] = (temp[new_gcd] + gcd_count[g]) % mod;
        }

        temp[x] = (temp[x] + 1) % mod;

        for (int g = 1; g <= max_val; g++) {
            gcd_count[g] = (gcd_count[g] + temp[g]) % mod;
        }

        free(temp);
    }

    int result = gcd_count[1] % mod;
    free(gcd_count);
    return result;
}

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}