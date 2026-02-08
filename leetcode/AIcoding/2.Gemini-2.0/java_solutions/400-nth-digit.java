class Solution {
    public int findNthDigit(int n) {
        long digit = 1;
        long count = 9;
        long start = 1;

        while (n > digit * count) {
            n -= digit * count;
            digit++;
            count *= 10;
            start *= 10;
        }

        long num = start + (n - 1) / digit;
        int index = (int) ((n - 1) % digit);

        String s = String.valueOf(num);
        return Character.getNumericValue(s.charAt(index));
    }
}