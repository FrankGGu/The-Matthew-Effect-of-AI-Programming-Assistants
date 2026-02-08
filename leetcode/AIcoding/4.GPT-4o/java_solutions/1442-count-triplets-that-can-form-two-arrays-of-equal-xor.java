class Solution {
    public int countTriplets(int[] arr) {
        int n = arr.length;
        int count = 0;
        int[] prefixXor = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefixXor[i + 1] = prefixXor[i] ^ arr[i];
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                if ((prefixXor[j] ^ prefixXor[i]) == 0) {
                    count += j - i - 1;
                }
            }
        }

        return count;
    }
}