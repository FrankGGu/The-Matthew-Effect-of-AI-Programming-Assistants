class Solution {
    public int countTriplets(int[] arr) {
        int n = arr.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] ^ arr[i];
        }
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                for (int k = j; k < n; k++) {
                    int a = prefix[j] ^ prefix[i];
                    int b = prefix[k + 1] ^ prefix[j];
                    if (a == b) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}