class Solution {
public:
    vector<string> cellsInRange(string s) {
        vector<string> result;
        char startCol = s[0], endCol = s[3];
        int startRow = s[1] - '0', endRow = s[4] - '0';

        for (char col = startCol; col <= endCol; ++col) {
            for (int row = startRow; row <= endRow; ++row) {
                result.push_back(string(1, col) + to_string(row));
            }
        }
        return result;
    }
};