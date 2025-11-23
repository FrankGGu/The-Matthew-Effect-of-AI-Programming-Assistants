class Solution {
    public int clearDigits(int n) {
        int count = 0;
        while (n > 0) {
            if (n % 10 == 0) {
                count++;
            }
            n /= 10;
        }
        return count;
    }
}