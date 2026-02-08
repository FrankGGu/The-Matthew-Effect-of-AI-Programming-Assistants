class Solution {
public:
    bool isTransformable(string s, string t) {
        vector<queue<int>> pos(10);
        for (int i = 0; i < s.size(); ++i) {
            pos[s[i] - '0'].push(i);
        }
        for (char c : t) {
            int d = c - '0';
            if (pos[d].empty()) {
                return false;
            }
            for (int i = 0; i < d; ++i) {
                if (!pos[i].empty() && pos[i].front() < pos[d].front()) {
                    return false;
                }
            }
            pos[d].pop();
        }
        return true;
    }
};