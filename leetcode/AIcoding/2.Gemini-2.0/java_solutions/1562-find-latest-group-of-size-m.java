class Solution {
    public int findLatestStep(int[] arr, int m) {
        int n = arr.length;
        if (m == n) {
            return n;
        }
        int[] length = new int[n + 2];
        int[] count = new int[n + 1];
        int ans = -1;
        for (int i = 0; i < n; i++) {
            int a = arr[i];
            int left = length[a - 1];
            int right = length[a + 1];
            length[a - left] = left + right + 1;
            length[a + right] = left + right + 1;
            length[a] = left + right + 1;
            count[left]--;
            count[right]--;
            count[left + right + 1]++;
            if (count[m] > 0) {
                ans = i + 1;
            }
        }
        return ans;
    }
}