public class Solution {
    public String smallestGoodBase(String n) {
        long N = Long.parseLong(n);
        int maxLen = (int) (Math.log(N) / Math.log(2)) + 1;
        for (int k = maxLen; k >= 2; k--) {
            long low = 2;
            long high = N;
            while (low <= high) {
                long mid = (low + high) / 2;
                long sum = 0;
                long cur = 1;
                for (int i = 0; i < k; i++) {
                    sum += cur;
                    cur *= mid;
                    if (sum > N) break;
                }
                if (sum == N) return String.valueOf(mid);
                else if (sum < N) low = mid + 1;
                else high = mid - 1;
            }
        }
        return String.valueOf(N);
    }
}