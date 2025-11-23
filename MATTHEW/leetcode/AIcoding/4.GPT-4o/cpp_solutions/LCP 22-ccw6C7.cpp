class Solution {
public:
    string[] findBlackWhite(int n) {
        vector<string> result;
        for (int i = 0; i < n; ++i) {
            string row;
            for (int j = 0; j < n; ++j) {
                row += (i % 2 == 0) ? (j % 2 == 0 ? 'B' : 'W') : (j % 2 == 0 ? 'W' : 'B');
            }
            result.push_back(row);
        }
        return result;
    }
};