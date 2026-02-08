class Solution {
public:
    long long maxPower(vector<int>& stations, int r, int k) {
        int n = stations.size();
        vector<long long> power(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            int left = max(0, i - r);
            int right = min(n - 1, i + r);
            power[left] += stations[i];
            if (right + 1 < n) power[right + 1] -= stations[i];
        }
        for (int i = 1; i < n; ++i) {
            power[i] += power[i - 1];
        }
        power.pop_back();

        auto check = [&](long long min_power) {
            vector<long long> diff(n + 1, 0);
            long long sum = 0;
            long long need = 0;
            for (int i = 0; i < n; ++i) {
                sum += diff[i];
                long long current = power[i] + sum;
                if (current < min_power) {
                    long long add = min_power - current;
                    need += add;
                    if (need > k) return false;
                    sum += add;
                    int right = min(n - 1, i + 2 * r);
                    if (right + 1 < n) diff[right + 1] -= add;
                }
            }
            return need <= k;
        };

        long long left = *min_element(power.begin(), power.end());
        long long right = left + k;
        long long ans = left;
        while (left <= right) {
            long long mid = left + (right - left) / 2;
            if (check(mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }
};