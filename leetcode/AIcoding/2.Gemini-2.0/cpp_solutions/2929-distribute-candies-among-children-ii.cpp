class Solution {
public:
    long long distributeCandies(int n, int limit) {
        long long ans = 0;
        for (int i = 0; i <= limit; ++i) {
            int remaining = n - i;
            if (remaining < 0) continue;
            long long max_val = min((long long)limit, (long long)remaining);
            long long min_val = max(0LL, (long long)remaining - (long long)limit);
            ans += max_val - min_val + 1;
        }
        return ans;
    }
};