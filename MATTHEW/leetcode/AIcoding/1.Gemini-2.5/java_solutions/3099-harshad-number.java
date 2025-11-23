class Solution {
    public int sumOfTheDigitsOfHarshadNumber(int x) {
        int sumDigits = 0;
        int tempX = x;

        while (tempX > 0) {
            sumDigits += tempX % 10;
            tempX /= 10;
        }

        if (x % sumDigits == 0) {
            return sumDigits;
        } else {
            return -1;
        }
    }
}