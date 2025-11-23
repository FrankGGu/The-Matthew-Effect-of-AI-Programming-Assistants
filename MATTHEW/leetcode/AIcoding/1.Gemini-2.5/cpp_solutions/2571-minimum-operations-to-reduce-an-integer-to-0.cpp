class Solution {
public:
    int minOperations(int n) {
        int operations = 0;
        while (n != 0) {
            if (n % 2 == 0) {
                n /= 2;
            } else {
                if ((n % 4) == 1) {
                    n = (n - 1) / 2;
                } else { // n % 4 == 3
                    n = (n + 1) / 2;
                }
                operations++;
            }
        }
        return operations;
    }
};