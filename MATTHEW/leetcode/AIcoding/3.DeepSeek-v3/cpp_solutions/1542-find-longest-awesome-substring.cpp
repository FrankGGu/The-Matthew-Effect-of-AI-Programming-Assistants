class Solution {
public:
    int longestAwesome(string s) {
        unordered_map<int, int> prefix;
        prefix[0] = -1;
        int mask = 0;
        int max_len = 0;
        for (int i = 0; i < s.size(); ++i) {
            mask ^= (1 << (s[i] - '0'));
            if (prefix.count(mask)) {
                max_len = max(max_len, i - prefix[mask]);
            } else {
                prefix[mask] = i;
            }
            for (int j = 0; j < 10; ++j) {
                int temp_mask = mask ^ (1 << j);
                if (prefix.count(temp_mask)) {
                    max_len = max(max_len, i - prefix[temp_mask]);
                }
            }
        }
        return max_len;
    }
};