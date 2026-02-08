class Solution {
public:
    string getSmallestString(string s, int k) {
        for (int i = 0; i < s.size() && k > 0; ++i) {
            char current = s[i];
            char target = 'a';
            int diff1 = (current - target + 26) % 26;
            int diff2 = (target - current + 26) % 26;
            int min_diff = min(diff1, diff2);
            if (k >= min_diff) {
                k -= min_diff;
                s[i] = 'a';
            } else {
                s[i] -= k;
                k = 0;
            }
        }
        return s;
    }
};