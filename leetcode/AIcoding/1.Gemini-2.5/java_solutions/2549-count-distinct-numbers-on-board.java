class Solution {
    public int distinctNumbersOnBoard(int n) {
        if (n == 1) {
            return 1;
        } else {
            return n - 1;
        }
    }
}