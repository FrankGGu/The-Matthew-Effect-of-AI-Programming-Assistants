class Solution {
public:
    long long maximumSubsequenceCount(string text, string pattern) {
        char a = pattern[0], b = pattern[1];
        long long res = 0, cnt_a = 0, cnt_b = 0;

        for (char c : text) {
            if (c == b) {
                res += cnt_a;
                cnt_b++;
            }
            if (c == a) {
                cnt_a++;
            }
        }

        return res + max(cnt_a, cnt_b);
    }
};