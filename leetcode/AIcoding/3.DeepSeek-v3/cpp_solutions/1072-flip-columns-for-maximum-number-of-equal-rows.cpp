class Solution {
public:
    int maxEqualRowsAfterFlips(vector<vector<int>>& matrix) {
        unordered_map<string, int> patternCount;
        int maxCount = 0;

        for (const auto& row : matrix) {
            string pattern;
            int first = row[0];
            for (int num : row) {
                pattern += (num == first) ? '0' : '1';
            }
            patternCount[pattern]++;
            maxCount = max(maxCount, patternCount[pattern]);
        }

        return maxCount;
    }
};