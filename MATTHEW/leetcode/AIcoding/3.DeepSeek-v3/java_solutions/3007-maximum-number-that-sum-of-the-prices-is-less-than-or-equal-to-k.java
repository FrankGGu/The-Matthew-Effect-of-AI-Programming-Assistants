class Solution {
    public long findMaximumNumber(long k, int x) {
        long left = 1;
        long right = (long) 1e15;
        long answer = 0;

        while (left <= right) {
            long mid = left + (right - left) / 2;
            long sum = calculateSum(mid, x);
            if (sum <= k) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return answer;
    }

    private long calculateSum(long num, int x) {
        long sum = 0;
        for (int i = 0; (1L << i) <= num; i++) {
            if ((i + 1) % x != 0) continue;
            long divisor = 1L << (i + 1);
            long quotient = num / divisor;
            long remainder = num % divisor;
            long count = quotient * (divisor / 2);
            count += Math.max(0, remainder - (divisor / 2) + 1);
            sum += count;
        }
        return sum;
    }
}