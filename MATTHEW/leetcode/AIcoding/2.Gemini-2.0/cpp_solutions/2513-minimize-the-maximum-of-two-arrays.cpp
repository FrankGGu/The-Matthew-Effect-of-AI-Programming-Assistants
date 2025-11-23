class Solution {
public:
    int minimizeSet(int divisor1, int divisor2, int uniqueCnt1, int uniqueCnt2) {
        long long low = 1, high = 2e9;
        long long lcm = (long long)divisor1 * divisor2 / std::gcd(divisor1, divisor2);
        while (low < high) {
            long long mid = low + (high - low) / 2;
            long long cnt1 = mid - mid / divisor1;
            long long cnt2 = mid - mid / divisor2;
            long long both = mid - mid / divisor1 - mid / divisor2 + mid / lcm;
            if (cnt1 >= uniqueCnt1 && cnt2 >= uniqueCnt2 && cnt1 + cnt2 - both >= uniqueCnt1 + uniqueCnt2) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return low;
    }
};