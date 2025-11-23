class Solution {
public:
    string longestSpecialSubstring(string s) {
        int n = s.size();
        unordered_map<string, int> count;
        string result = "";

        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                string substring = s.substr(i, len);
                count[substring]++;
                if (count[substring] == 3 && substring.length() > result.length()) {
                    result = substring;
                }
            }
            count.clear();
        }

        return result;
    }
};