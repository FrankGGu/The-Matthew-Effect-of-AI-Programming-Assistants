class Solution {
public:
    int minimumOperations(int num) {
        int operations = 0;
        while (num > 0) {
            operations++;
            int minDigit = 9;
            int temp = num;
            while (temp > 0) {
                minDigit = min(minDigit, temp % 10);
                temp /= 10;
            }
            num -= minDigit;
        }
        return operations;
    }
};