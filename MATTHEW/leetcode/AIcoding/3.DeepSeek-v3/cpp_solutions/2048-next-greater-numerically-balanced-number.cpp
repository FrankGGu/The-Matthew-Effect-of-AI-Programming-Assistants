class Solution {
public:
    int nextBeautifulNumber(int n) {
        for (int num = n + 1; ; ++num) {
            if (isBalanced(num)) {
                return num;
            }
        }
        return -1;
    }

private:
    bool isBalanced(int num) {
        vector<int> count(10, 0);
        while (num > 0) {
            int digit = num % 10;
            if (digit == 0) return false;
            count[digit]++;
            num /= 10;
        }
        for (int i = 1; i < 10; ++i) {
            if (count[i] != 0 && count[i] != i) {
                return false;
            }
        }
        return true;
    }
};