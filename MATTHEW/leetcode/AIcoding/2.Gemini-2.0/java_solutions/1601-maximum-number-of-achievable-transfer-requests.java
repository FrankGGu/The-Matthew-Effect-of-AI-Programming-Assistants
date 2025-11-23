class Solution {
    public int maximumRequests(int n, int[][] requests) {
        int m = requests.length;
        int ans = 0;
        for (int i = 0; i < (1 << m); i++) {
            int[] balance = new int[n];
            int count = 0;
            for (int j = 0; j < m; j++) {
                if ((i & (1 << j)) != 0) {
                    balance[requests[j][0]]--;
                    balance[requests[j][1]]++;
                    count++;
                }
            }
            boolean valid = true;
            for (int k = 0; k < n; k++) {
                if (balance[k] != 0) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                ans = Math.max(ans, count);
            }
        }
        return ans;
    }
}