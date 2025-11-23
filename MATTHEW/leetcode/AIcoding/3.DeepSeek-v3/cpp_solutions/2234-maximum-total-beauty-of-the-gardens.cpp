class Solution {
public:
    long long maximumBeauty(vector<int>& flowers, long long newFlowers, int target, int full, int partial) {
        sort(flowers.begin(), flowers.end());
        long long n = flowers.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + flowers[i];
        }

        long long res = 0;
        int j = 0;
        for (int i = 0; i <= n; ++i) {
            long long remaining = newFlowers;
            if (i > 0) {
                remaining -= max(0LL, target - flowers[n - i]);
                if (remaining < 0) break;
            }
            while (j < n - i && (long long)flowers[j] * j - prefix[j] <= remaining) {
                ++j;
            }
            long long min_flower = 0;
            if (j > 0) {
                long long total = prefix[j] + remaining;
                min_flower = min(total / j, (long long)target - 1);
            }
            res = max(res, (long long)full * i + (long long)partial * min_flower);
        }
        return res;
    }
};