public class Solution {
    public int reverseInteger(int num) {
        int reversed = 0;
        while (num != 0) {
            reversed = reversed * 10 + num % 10;
            num /= 10;
        }
        return reversed;
    }

    public boolean isNumberAfterDoubleReversal(int num) {
        int firstReversed = reverseInteger(num);
        int secondReversed = reverseInteger(firstReversed);
        return secondReversed == num;
    }

    public int numberAfterDoubleReversal(int num) {
        int firstReversed = reverseInteger(num);
        int secondReversed = reverseInteger(firstReversed);
        return secondReversed;
    }
}