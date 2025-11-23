class Solution {
public:
    int countDevices(int n, vector<vector<int>>& tests) {
        vector<int> count(n + 1, 0);
        for (const auto& test : tests) {
            count[test[0]]++;
            count[test[1]]++;
        }

        int result = 0;
        for (int i = 1; i <= n; ++i) {
            if (count[i] > 0) {
                result++;
            }
        }
        return result;
    }
};