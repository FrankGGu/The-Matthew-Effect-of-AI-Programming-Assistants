class Solution {
public:
    bool isSpecial(int num) {
        for (int i = 2; i * i <= num; ++i) {
            if (num % i == 0) {
                if (num % (i * i) == 0) {
                    return true;
                }
            }
        }
        return false;
    }

    int countSpecialNumbers(int n) {
        int count = 0;
        for (int i = 1; i <= n; ++i) {
            if (isSpecial(i)) {
                ++count;
            }
        }
        return n - count;
    }
};