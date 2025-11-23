class Solution {
    public int makeNumbersEqual(int num1, int num2) {
        if (num1 == num2) {
            return 0;
        }
        int operations = 0;
        while (num1 != num2) {
            if (num1 > num2) {
                if (num1 % 2 == 0) {
                    num1 /= 2;
                } else {
                    num1 += 1;
                }
            } else {
                if (num2 % 2 == 0) {
                    num2 /= 2;
                } else {
                    num2 += 1;
                }
            }
            operations++;
        }
        return operations;
    }
}