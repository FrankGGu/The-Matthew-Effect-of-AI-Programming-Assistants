class Solution {
    public int[] findSneakyNumbers(int[] digits) {
        int n = digits.length;
        int sum = 0;
        int xor = 0;
        for (int i = 0; i < n; i++) {
            sum += digits[i];
            xor ^= digits[i];
        }
        int a = (sum - xor) / 2;
        int b = sum - a;
        return new int[]{Math.min(a, b), Math.max(a, b)};
    }
}