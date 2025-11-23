class Solution {
    public int nextBeautifulNumber(int n) {
        for (int i = n + 1; i <= 1224444; i++) {
            if (isBalanced(i)) {
                return i;
            }
        }
        return -1;
    }

    private boolean isBalanced(int num) {
        int[] count = new int[10];
        while (num > 0) {
            int digit = num % 10;
            if (digit == 0) {
                return false;
            }
            count[digit]++;
            num /= 10;
        }
        for (int i = 1; i < 10; i++) {
            if (count[i] != 0 && count[i] != i) {
                return false;
            }
        }
        return true;
    }
}