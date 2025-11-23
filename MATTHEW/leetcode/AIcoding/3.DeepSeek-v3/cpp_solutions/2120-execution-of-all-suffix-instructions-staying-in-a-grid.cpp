class Solution {
public:
    vector<int> executeInstructions(int n, vector<int>& startPos, string s) {
        vector<int> res;
        int m = s.size();
        for (int i = 0; i < m; ++i) {
            int x = startPos[0], y = startPos[1];
            int cnt = 0;
            for (int j = i; j < m; ++j) {
                char c = s[j];
                if (c == 'L') y--;
                else if (c == 'R') y++;
                else if (c == 'U') x--;
                else if (c == 'D') x++;
                if (x < 0 || x >= n || y < 0 || y >= n) break;
                cnt++;
            }
            res.push_back(cnt);
        }
        return res;
    }
};