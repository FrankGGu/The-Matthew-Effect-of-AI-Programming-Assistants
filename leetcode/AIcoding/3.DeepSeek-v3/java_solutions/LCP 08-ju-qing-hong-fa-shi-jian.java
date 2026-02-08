class Solution {
    public int[] getTriggerTime(int[][] increase, int[][] requirements) {
        int n = increase.length;
        int[][] prefix = new int[n + 1][3];
        for (int i = 1; i <= n; i++) {
            prefix[i][0] = prefix[i - 1][0] + increase[i - 1][0];
            prefix[i][1] = prefix[i - 1][1] + increase[i - 1][1];
            prefix[i][2] = prefix[i - 1][2] + increase[i - 1][2];
        }
        int m = requirements.length;
        int[] res = new int[m];
        for (int i = 0; i < m; i++) {
            int[] req = requirements[i];
            int left = 0, right = n;
            int ans = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (prefix[mid][0] >= req[0] && prefix[mid][1] >= req[1] && prefix[mid][2] >= req[2]) {
                    ans = mid;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            res[i] = ans;
        }
        return res;
    }
}