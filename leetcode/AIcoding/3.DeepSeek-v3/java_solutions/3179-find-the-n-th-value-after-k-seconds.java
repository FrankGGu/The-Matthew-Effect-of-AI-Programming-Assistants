class Solution {
    public int valueAfterKSeconds(int n, int k) {
        int MOD = 1000000007;
        int[] arr = new int[n];
        Arrays.fill(arr, 1);

        for (int sec = 1; sec <= k; sec++) {
            for (int i = 1; i < n; i++) {
                arr[i] = (arr[i] + arr[i - 1]) % MOD;
            }
        }

        return arr[n - 1];
    }
}