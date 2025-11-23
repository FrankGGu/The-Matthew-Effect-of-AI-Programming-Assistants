class Solution {
    public int minimizeSet(int divisor1, int divisor2, int uniqueCnt1, int uniqueCnt2) {
        long low = 1, high = (long) 2e9;
        while (low < high) {
            long mid = low + (high - low) / 2;
            long cnt1 = mid - mid / divisor1;
            long cnt2 = mid - mid / divisor2;
            long cnt12 = mid - mid / divisor1 - mid / divisor2 + mid / lcm(divisor1, divisor2);
            if (cnt1 >= uniqueCnt1 && cnt2 >= uniqueCnt2 && cnt12 >= uniqueCnt1 + uniqueCnt2) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return (int) low;
    }

    private long gcd(long a, long b) {
        if (b == 0) return a;
        return gcd(b, a % b);
    }

    private long lcm(long a, long b) {
        return a * b / gcd(a, b);
    }
}