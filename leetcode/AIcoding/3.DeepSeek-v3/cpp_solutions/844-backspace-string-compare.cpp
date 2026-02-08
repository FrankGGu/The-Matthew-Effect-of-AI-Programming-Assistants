class Solution {
public:
    bool backspaceCompare(string s, string t) {
        string s1, t1;
        for (char c : s) {
            if (c == '#') {
                if (!s1.empty()) {
                    s1.pop_back();
                }
            } else {
                s1.push_back(c);
            }
        }
        for (char c : t) {
            if (c == '#') {
                if (!t1.empty()) {
                    t1.pop_back();
                }
            } else {
                t1.push_back(c);
            }
        }
        return s1 == t1;
    }
};