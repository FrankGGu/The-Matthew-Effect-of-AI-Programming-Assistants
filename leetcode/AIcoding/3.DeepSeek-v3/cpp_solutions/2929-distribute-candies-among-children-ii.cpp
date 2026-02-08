class Solution {
public:
    long long distributeCandies(int n, int limit) {
        long long res = 0;
        for (int i = 0; i <= min(n, limit); ++i) {
            int remaining = n - i;
            int upper = min(remaining, limit);
            int lower = max(0, remaining - limit);
            if (lower <= upper) {
                res += (upper - lower + 1);
            }
        }
        return res;
    }
};