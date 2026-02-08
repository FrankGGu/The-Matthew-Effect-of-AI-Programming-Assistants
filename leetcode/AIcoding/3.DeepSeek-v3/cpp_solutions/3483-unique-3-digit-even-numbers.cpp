class Solution {
public:
    int countEven(int num) {
        int count = 0;
        for (int i = 100; i <= num; ++i) {
            if (i % 2 == 0) {
                int n = i;
                int sum = 0;
                while (n > 0) {
                    sum += n % 10;
                    n /= 10;
                }
                if (sum % 2 == 0) {
                    ++count;
                }
            }
        }
        return count;
    }
};