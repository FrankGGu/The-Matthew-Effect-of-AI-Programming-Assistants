class Solution {
public:
    int countSpecialNumbers(int n) {
        string s = to_string(n);
        int len = s.length();
        int ans = 0;
        for (int i = 1; i < len; ++i) {
            int temp = 9;
            for (int j = 1; j < i; ++j) {
                temp *= (10 - j);
            }
            ans += temp;
        }

        vector<bool> used(10, false);
        for (int i = 0; i < len; ++i) {
            int digit = s[i] - '0';
            for (int j = (i == 0 ? 1 : 0); j < digit; ++j) {
                if (!used[j]) {
                    int temp = 1;
                    int remaining = len - i - 1;
                    int available = 10 - i - 1;
                    for (int k = 0; k < remaining; ++k) {
                        temp *= (available - k);
                    }
                    ans += temp;
                }
            }
            if (used[digit]) {
                break;
            }
            used[digit] = true;
            if (i == len - 1) {
                ans++;
            }
        }

        return n - ans;
    }
};