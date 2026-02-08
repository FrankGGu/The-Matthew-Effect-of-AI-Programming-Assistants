public class Solution {
    public int countNonSpecialNumbers(int start, int end) {
        int count = 0;
        for (int i = start; i <= end; i++) {
            if (!isSpecial(i)) {
                count++;
            }
        }
        return count;
    }

    private boolean isSpecial(int num) {
        int n = num;
        int[] freq = new int[10];
        while (n > 0) {
            int digit = n % 10;
            freq[digit]++;
            if (freq[digit] > 1) {
                return true;
            }
            n /= 10;
        }
        return false;
    }
}