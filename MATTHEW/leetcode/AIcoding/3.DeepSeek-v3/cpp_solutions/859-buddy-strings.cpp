class Solution {
public:
    bool buddyStrings(string s, string goal) {
        if (s.size() != goal.size()) return false;
        if (s == goal) {
            unordered_set<char> seen;
            for (char c : s) {
                if (seen.count(c)) return true;
                seen.insert(c);
            }
            return false;
        } else {
            vector<int> diff;
            for (int i = 0; i < s.size(); ++i) {
                if (s[i] != goal[i]) {
                    diff.push_back(i);
                }
            }
            return diff.size() == 2 && s[diff[0]] == goal[diff[1]] && s[diff[1]] == goal[diff[0]];
        }
    }
};