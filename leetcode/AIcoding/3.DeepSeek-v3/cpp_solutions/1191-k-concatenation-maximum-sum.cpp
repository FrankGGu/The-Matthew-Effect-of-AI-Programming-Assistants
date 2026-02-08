class Solution {
public:
    int kConcatenationMaxSum(vector<int>& arr, int k) {
        const int MOD = 1e9 + 7;
        long long max_prefix = 0, max_suffix = 0, total = 0;
        long long current_prefix = 0, current_suffix = 0;
        int n = arr.size();

        for (int i = 0; i < n; ++i) {
            current_prefix += arr[i];
            max_prefix = max(max_prefix, current_prefix);
        }

        for (int i = n - 1; i >= 0; --i) {
            current_suffix += arr[i];
            max_suffix = max(max_suffix, current_suffix);
        }

        total = current_prefix;

        long long max_subarray = 0;
        long long current = 0;
        for (int num : arr) {
            current += num;
            if (current < 0) current = 0;
            max_subarray = max(max_subarray, current);
        }

        if (k == 1) {
            return max_subarray % MOD;
        }

        long long option1 = max_prefix + max_suffix;
        long long option2 = max_prefix + max_suffix + (k - 2) * total;
        long long max_sum = max(max_subarray, max(option1, option2));

        return max_sum > 0 ? max_sum % MOD : 0;
    }
};