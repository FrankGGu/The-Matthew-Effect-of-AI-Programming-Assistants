class Solution {
public:
    int minimumMoves(string s) {
        int n = s.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (s[i] == 'X') {
                count++;
                i += 2;
            }
        }
        return count;
    }
};