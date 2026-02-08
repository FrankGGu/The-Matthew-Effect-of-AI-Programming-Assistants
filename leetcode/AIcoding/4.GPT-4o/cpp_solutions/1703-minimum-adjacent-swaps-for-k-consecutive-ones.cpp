class Solution {
public:
    int minSwaps(vector<int>& data, int k) {
        int n = data.size();
        vector<int> ones;
        for (int i = 0; i < n; ++i) {
            if (data[i] == 1) ones.push_back(i);
        }
        int m = ones.size();
        if (k == 0 || k == m) return 0;

        int minSwaps = INT_MAX;
        for (int i = 0; i <= m - k; ++i) {
            int left = ones[i];
            int right = ones[i + k - 1];
            int expectedPosition = left + k - 1;
            int currentSwaps = expectedPosition - right;
            minSwaps = min(minSwaps, currentSwaps);
        }
        return minSwaps;
    }
};