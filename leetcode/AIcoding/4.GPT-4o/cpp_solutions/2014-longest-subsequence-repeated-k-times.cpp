class Solution {
public:
    string longestSubsequenceRepeatedK(string s, int k) {
        unordered_map<string, int> freq;
        int n = s.size();
        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                string sub = s.substr(i, len);
                freq[sub]++;
            }
        }
        string result;
        for (auto& [sub, count] : freq) {
            if (count >= k && sub.size() > result.size()) {
                result = sub;
            }
        }
        return result;
    }
};