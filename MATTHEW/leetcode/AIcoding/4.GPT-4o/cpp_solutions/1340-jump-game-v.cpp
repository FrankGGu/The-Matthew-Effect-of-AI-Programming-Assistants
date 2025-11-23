class Solution {
public:
    int maxJumps(vector<int>& arr, int d) {
        int n = arr.size();
        vector<int> dp(n, 1);
        vector<int> indices(n);
        iota(indices.begin(), indices.end(), 0);

        sort(indices.begin(), indices.end(), [&arr](int a, int b) {
            return arr[a] < arr[b];
        });

        for (int idx : indices) {
            for (int step = 1; step <= d; ++step) {
                if (idx - step >= 0 && arr[idx] > arr[idx - step]) {
                    dp[idx] = max(dp[idx], dp[idx - step] + 1);
                } else {
                    break;
                }
            }
            for (int step = 1; step <= d; ++step) {
                if (idx + step < n && arr[idx] > arr[idx + step]) {
                    dp[idx] = max(dp[idx], dp[idx + step] + 1);
                } else {
                    break;
                }
            }
        }

        return *max_element(dp.begin(), dp.end());
    }
};