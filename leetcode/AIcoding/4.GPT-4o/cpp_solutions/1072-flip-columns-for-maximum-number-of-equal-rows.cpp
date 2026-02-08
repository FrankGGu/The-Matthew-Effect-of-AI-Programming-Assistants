class Solution {
public:
    int maxEqualRowsAfterFlips(vector<vector<int>>& matrix) {
        unordered_map<string, int> count;
        int maxCount = 0;

        for (const auto& row : matrix) {
            string key;
            for (int val : row) {
                key += to_string(val ^ row[0]);
            }
            count[key]++;
            maxCount = max(maxCount, count[key]);
        }

        return maxCount;
    }
};