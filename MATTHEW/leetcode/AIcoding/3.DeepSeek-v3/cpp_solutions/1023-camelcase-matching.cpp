class Solution {
public:
    vector<bool> camelMatch(vector<string>& queries, string pattern) {
        vector<bool> ans;
        for (auto& s : queries) {
            ans.push_back(isMatch(s, pattern));
        }
        return ans;
    }

    bool isMatch(string s, string pattern) {
        int j = 0;
        for (int i = 0; i < s.size(); i++) {
            if (j < pattern.size() && s[i] == pattern[j]) {
                j++;
            } else if (s[i] >= 'A' && s[i] <= 'Z') {
                return false;
            }
        }
        return j == pattern.size();
    }
};