public class Solution {
    public int nextBeautifulNumber(int n) {
        for (int i = n + 1; ; i++) {
            if (isNextGreaterNumericallyBalanced(i)) {
                return i;
            }
        }
    }

    private boolean isNextGreaterNumericallyBalanced(int num) {
        int[] count = new int[7];
        int temp = num;
        while (temp > 0) {
            int digit = temp % 10;
            count[digit]++;
            temp /= 10;
        }
        for (int i = 1; i <= 6; i++) {
            if (count[i] != 0 && count[i] != i) {
                return false;
            }
        }
        return true;
    }
}