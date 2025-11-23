class Solution {
public:
    string sortString(string s) {
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }
        string result;
        while (result.size() < s.size()) {
            for (int i = 0; i < 26; ++i) {
                if (count[i] > 0) {
                    result += 'a' + i;
                    count[i]--;
                }
            }
            for (int i = 25; i >= 0; --i) {
                if (count[i] > 0) {
                    result += 'a' + i;
                    count[i]--;
                }
            }
        }
        return result;
    }
};