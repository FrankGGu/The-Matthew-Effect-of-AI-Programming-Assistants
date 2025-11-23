class Solution {
public:
    int monotoneIncreasingDigits(int n) {
        string num = to_string(n);
        int len = num.length();
        int mark = len;

        for (int i = len - 1; i > 0; i--) {
            if (num[i] < num[i - 1]) {
                mark = i;
                num[i - 1]--;
            }
        }

        for (int i = mark; i < len; i++) {
            num[i] = '9';
        }

        return stoi(num);
    }
};