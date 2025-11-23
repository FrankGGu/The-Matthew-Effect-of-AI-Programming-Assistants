class Solution {
    public int countDigits(int num) {
        int count = 0;
        int originalNum = num;
        int tempNum = num;

        while (tempNum > 0) {
            int digit = tempNum % 10;
            if (originalNum % digit == 0) {
                count++;
            }
            tempNum /= 10;
        }

        return count;
    }
}