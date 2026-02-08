class Solution {
public:
    vector<vector<int>> largeGroupPositions(string s) {
        vector<vector<int>> result;
        int n = s.size();
        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && s[j] == s[i]) {
                j++;
            }
            if (j - i >= 3) {
                result.push_back({i, j - 1});
            }
            i = j;
        }
        return result;
    }
};