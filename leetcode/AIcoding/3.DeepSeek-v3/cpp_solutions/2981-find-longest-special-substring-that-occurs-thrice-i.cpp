class Solution {
public:
    int maximumLength(string s) {
        unordered_map<string, int> freq;
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                if (j > i && s[j] != s[i]) break;
                string sub = s.substr(i, j - i + 1);
                freq[sub]++;
            }
        }
        int max_len = -1;
        for (auto& [sub, cnt] : freq) {
            if (cnt >= 3) {
                max_len = max(max_len, (int)sub.size());
            }
        }
        return max_len;
    }
};