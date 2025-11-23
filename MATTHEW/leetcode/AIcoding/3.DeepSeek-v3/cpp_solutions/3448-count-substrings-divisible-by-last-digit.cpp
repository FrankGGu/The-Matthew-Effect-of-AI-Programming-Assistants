class Solution {
public:
    int countDivisibleSubstrings(string word) {
        int n = word.size();
        int res = 0;
        for (int i = 0; i < n; ++i) {
            int sum = 0;
            for (int j = i; j < n; ++j) {
                sum += word[j] - 'a' + 1;
                int len = j - i + 1;
                if (sum % len == 0) {
                    int lastDigit = sum % 10;
                    if (lastDigit == 0) lastDigit = 10;
                    if (len == lastDigit) {
                        res++;
                    }
                }
            }
        }
        return res;
    }
};