typedef long long ll;

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

long long countPairs(int* nums, int numsSize, int k) {
    ll ans = 0;
    int* freq = (int*)calloc(k + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        int g = gcd(nums[i], k);
        freq[g]++;
    }

    for (int i = 1; i <= k; i++) {
        if (freq[i] == 0) continue;
        for (int j = i; j <= k; j++) {
            if (freq[j] == 0) continue;
            if ((ll)i * j % k == 0) {
                if (i == j) {
                    ans += (ll)freq[i] * (freq[i] - 1) / 2;
                } else {
                    ans += (ll)freq[i] * freq[j];
                }
            }
        }
    }

    free(freq);
    return ans;
}