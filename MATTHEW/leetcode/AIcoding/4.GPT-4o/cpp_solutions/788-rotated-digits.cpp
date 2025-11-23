class Solution {
public:
    int rotatedDigits(int N) {
        int count = 0;
        for (int i = 1; i <= N; ++i) {
            int num = i;
            bool valid = true, diff = false;
            while (num > 0) {
                int digit = num % 10;
                if (digit == 3 || digit == 4 || digit == 7) {
                    valid = false;
                    break;
                }
                if (digit == 2 || digit == 5 || digit == 6 || digit == 9) {
                    diff = true;
                }
                num /= 10;
            }
            if (valid && diff) {
                count++;
            }
        }
        return count;
    }
};