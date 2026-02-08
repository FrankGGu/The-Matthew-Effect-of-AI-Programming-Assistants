class Solution {
    public boolean canArrange(int[] arr, int k) {
        int[] counts = new int[k];

        for (int num : arr) {
            int remainder = (num % k + k) % k;
            counts[remainder]++;
        }

        if (counts[0] % 2 != 0) {
            return false;
        }

        for (int i = 1; i <= k / 2; i++) {
            if (i == k - i) { // This condition handles the case where k is even and i = k/2
                if (counts[i] % 2 != 0) {
                    return false;
                }
            } else {
                if (counts[i] != counts[k - i]) {
                    return false;
                }
            }
        }

        return true;
    }
}