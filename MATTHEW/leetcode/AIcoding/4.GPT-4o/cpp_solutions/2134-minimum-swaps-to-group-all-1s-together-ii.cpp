class Solution {
public:
    int minSwaps(vector<int>& data) {
        int n = data.size();
        int ones = count(data.begin(), data.end(), 1);
        if (ones <= 1) return 0;

        int min_swaps = INT_MAX;
        vector<int> prefix(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            prefix[i] = prefix[i - 1] + data[i - 1];
        }

        for (int i = 0; i <= n; ++i) {
            if (i + ones <= n) {
                int current_swaps = ones - (prefix[i + ones] - prefix[i]);
                min_swaps = min(min_swaps, current_swaps);
            }
        }

        return min_swaps;
    }
};