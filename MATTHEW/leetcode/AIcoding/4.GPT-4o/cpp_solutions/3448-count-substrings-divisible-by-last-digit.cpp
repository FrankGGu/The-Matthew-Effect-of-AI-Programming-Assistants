class Solution {
public:
    int countDivisibleSubstrings(string s) {
        int count = 0, n = s.size();
        for (int i = 0; i < n; ++i) {
            int num = 0, lastDigit = s[i] - '0';
            for (int j = i; j < n; ++j) {
                num = num * 10 + (s[j] - '0');
                if (lastDigit != 0 && num % lastDigit == 0) {
                    count++;
                }
            }
        }
        return count;
    }
};