class Solution {
public:
    int maxSizeSlices(vector<int>& slices) {
        int n = slices.size() / 3;
        vector<int> dp1(n + 1, 0), dp2(n + 1, 0);

        for (int i = 0; i < slices.size() - 1; ++i) {
            for (int j = min(n, i + 1); j > 0; --j) {
                if (i < slices.size() - 1)
                    dp1[j] = max(dp1[j], dp1[j - 1] + slices[i]);
            }
        }

        for (int i = 1; i < slices.size(); ++i) {
            for (int j = min(n, i); j > 0; --j) {
                dp2[j] = max(dp2[j], dp2[j - 1] + slices[i]);
            }
        }

        return max(dp1[n], dp2[n]);
    }
};