typedef long long ll;

int waysToPartition(int* nums, int numsSize, int k) {
    int n = numsSize;
    ll total = 0;
    for (int i = 0; i < n; i++) {
        total += nums[i];
    }

    ll* prefix = (ll*)malloc(n * sizeof(ll));
    prefix[0] = nums[0];
    for (int i = 1; i < n; i++) {
        prefix[i] = prefix[i-1] + nums[i];
    }

    int max_ways = 0;

    // Without changing any element
    for (int i = 0; i < n-1; i++) {
        if (prefix[i] == total - prefix[i]) {
            max_ways++;
        }
    }

    // With changing one element
    ll* diff = (ll*)malloc(n * sizeof(ll));
    for (int i = 0; i < n; i++) {
        diff[i] = total - 2 * prefix[i];
    }

    ll* left_diff = (ll*)malloc(n * sizeof(ll));
    ll* right_diff = (ll*)malloc(n * sizeof(ll));
    for (int i = 0; i < n; i++) {
        left_diff[i] = diff[i];
        right_diff[i] = diff[i];
    }

    // Change at position p
    for (int p = 0; p < n; p++) {
        ll delta = k - nums[p];
        int count = 0;

        // For splits before p
        for (int i = 0; i < p; i++) {
            if (prefix[i] + (i >= p ? 0 : 0) == total - prefix[i] + delta) {
                count++;
            }
        }

        // For splits at or after p
        for (int i = p; i < n-1; i++) {
            if (prefix[i] + delta == total - prefix[i] + delta) {
                count++;
            }
        }

        if (count > max_ways) {
            max_ways = count;
        }
    }

    free(prefix);
    free(diff);
    free(left_diff);
    free(right_diff);

    return max_ways;
}