class Solution {
    public int minimizeSet(int divisor1, int divisor2, int uniqueCnt1, int uniqueCnt2) {
        long left = 1, right = Long.MAX_VALUE;
        long lcm = lcm(divisor1, divisor2);

        while (left < right) {
            long mid = left + (right - left) / 2;
            long notDiv1 = mid - mid / divisor1;
            long notDiv2 = mid - mid / divisor2;
            long notDivBoth = mid - mid / lcm;

            if (notDiv1 >= uniqueCnt1 && notDiv2 >= uniqueCnt2 && notDivBoth >= uniqueCnt1 + uniqueCnt2) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return (int) left;
    }

    private long gcd(long a, long b) {
        while (b != 0) {
            long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    private long lcm(long a, long b) {
        return a * b / gcd(a, b);
    }
}