class Solution {
public:
    vector<vector<int>> largeGroupPositions(string s) {
        vector<vector<int>> result;
        int n = s.size();
        int start = 0;
        for (int i = 1; i <= n; ++i) {
            if (i == n || s[i] != s[start]) {
                if (i - start >= 3) {
                    result.push_back({start, i - 1});
                }
                start = i;
            }
        }
        return result;
    }
};