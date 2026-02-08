class Solution {
public:
    string findLongestSpecialSubstring(string s) {
        int n = s.size();
        unordered_map<string, int> count;
        string longest = "";

        for (int len = 1; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                string sub = s.substr(i, len);
                count[sub]++;
                if (count[sub] == 3 && sub.length() > longest.length()) {
                    longest = sub;
                }
            }
            count.clear();
        }

        return longest;
    }
};