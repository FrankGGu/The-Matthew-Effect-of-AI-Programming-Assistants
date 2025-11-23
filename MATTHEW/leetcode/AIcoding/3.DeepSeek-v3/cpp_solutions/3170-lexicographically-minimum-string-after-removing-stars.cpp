class Solution {
public:
    string clearStars(string s) {
        vector<pair<char, int>> st;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '*') {
                if (!st.empty()) {
                    st.pop_back();
                }
            } else {
                st.emplace_back(s[i], i);
            }
        }
        sort(st.begin(), st.end(), [](const auto& a, const auto& b) {
            return a.second < b.second;
        });
        string res;
        for (const auto& p : st) {
            res += p.first;
        }
        return res;
    }
};