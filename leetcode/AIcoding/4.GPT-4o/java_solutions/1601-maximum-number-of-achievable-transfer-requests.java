public class Solution {
    public int maximumRequests(int n, int[][] requests) {
        int maxRequests = 0;
        int totalRequests = requests.length;

        for (int i = 0; i < (1 << totalRequests); i++) {
            int[] balance = new int[n];
            int count = 0;

            for (int j = 0; j < totalRequests; j++) {
                if ((i & (1 << j)) != 0) {
                    balance[requests[j][0]]--;
                    balance[requests[j][1]]++;
                    count++;
                }
            }

            if (isValid(balance)) {
                maxRequests = Math.max(maxRequests, count);
            }
        }

        return maxRequests;
    }

    private boolean isValid(int[] balance) {
        for (int b : balance) {
            if (b != 0) {
                return false;
            }
        }
        return true;
    }
}