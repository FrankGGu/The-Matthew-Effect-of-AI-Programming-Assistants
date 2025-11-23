class Solution {
public:
    long long maxRunTime(int n, vector<int>& batteries) {
        long long low = 0, high = accumulate(batteries.begin(), batteries.end(), 0LL) / n;

        while (low < high) {
            long long mid = low + (high - low + 1) / 2;
            long long total = 0;
            for (const auto& battery : batteries) {
                total += min(battery, mid);
            }
            if (total >= mid * n) {
                low = mid;
            } else {
                high = mid - 1;
            }
        }

        return low;
    }
};