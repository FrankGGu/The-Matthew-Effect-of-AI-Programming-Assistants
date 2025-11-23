class Solution {
public:
    int minMovesToMakePalindrome(string s) {
        int n = s.size();
        vector<int> count(256, 0);
        for (char c : s) count[c]++;
        int oddCount = 0;
        for (int c : count) if (c % 2 != 0) oddCount++;

        if (oddCount > 1) return -1;

        vector<int> positions;
        for (char c = 'a'; c <= 'z'; c++) {
            for (int i = 0; i < n; i++) {
                if (s[i] == c) {
                    positions.push_back(i);
                }
            }
        }

        int moves = 0;
        for (int i = 0; i < positions.size() / 2; i++) {
            moves += positions[positions.size() - 1 - i] - positions[i] - 1 - 2 * i;
        }

        return moves;
    }
};