class Solution {
public:
    int minimizeSet(int divisor1, int divisor2, int uniqueCnt1, int uniqueCnt2) {
        long left = 1, right = 1e15;
        long lcm_val = lcm(static_cast<long>(divisor1), static_cast<long>(divisor2));

        while (left < right) {
            long mid = left + (right - left) / 2;
            long not_div1 = mid - mid / divisor1;
            long not_div2 = mid - mid / divisor2;
            long not_div_either = mid - mid / divisor1 - mid / divisor2 + mid / lcm_val;

            if (not_div1 >= uniqueCnt1 && not_div2 >= uniqueCnt2 && not_div1 + not_div2 - not_div_either >= uniqueCnt1 + uniqueCnt2) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return static_cast<int>(left);
    }

private:
    long gcd(long a, long b) {
        return b == 0 ? a : gcd(b, a % b);
    }

    long lcm(long a, long b) {
        return a * b / gcd(a, b);
    }
};