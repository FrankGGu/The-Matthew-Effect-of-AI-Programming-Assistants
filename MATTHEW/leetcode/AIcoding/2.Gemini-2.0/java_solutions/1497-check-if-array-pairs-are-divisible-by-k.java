class Solution {
    public boolean canArrange(int[] arr, int k) {
        int[] remainders = new int[k];
        for (int num : arr) {
            int remainder = num % k;
            if (remainder < 0) {
                remainder += k;
            }
            remainders[remainder]++;
        }

        if (remainders[0] % 2 != 0) {
            return false;
        }

        for (int i = 1; i <= k / 2; i++) {
            if (remainders[i] != remainders[k - i]) {
                return false;
            }
        }

        return true;
    }
}