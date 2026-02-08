class Solution {
    public int minimumNumbers(int num, int k) {
        if (num == 0) return 0;
        for (int n = 1; n <= 10; ++n) {
            int sum = n * k;
            if (sum > num) break;
            if ((num - sum) % 10 == 0) {
                return n;
            }
        }
        return -1;
    }
}