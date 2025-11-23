class Solution {
    public int countKReducibleNumbers(int n, int k) {
        int count = 0;
        for (int i = 1; i < n; i++) {
            if (isKReducible(i, k)) {
                count++;
            }
        }
        return count;
    }

    private boolean isKReducible(int num, int k) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum % k == 0;
    }
}