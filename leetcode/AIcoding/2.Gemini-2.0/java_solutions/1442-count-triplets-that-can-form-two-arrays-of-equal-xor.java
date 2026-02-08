class Solution {
    public int countTriplets(int[] arr) {
        int n = arr.length;
        int count = 0;
        for (int i = 0; i < n - 1; i++) {
            for (int j = i + 1; j < n; j++) {
                for (int k = j; k < n; k++) {
                    int xor1 = 0;
                    for (int l = i; l < j; l++) {
                        xor1 ^= arr[l];
                    }
                    int xor2 = 0;
                    for (int l = j; l <= k; l++) {
                        xor2 ^= arr[l];
                    }
                    if (xor1 == xor2) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}