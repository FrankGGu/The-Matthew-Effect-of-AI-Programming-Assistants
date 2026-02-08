public class Solution {
    public long maximumNumber(long k) {
        long res = 0;
        long price = 0;
        long num = 1;
        while (price <= k) {
            long cnt = 0;
            long temp = num;
            while (temp > 0) {
                if (temp % 10 == 1) {
                    cnt++;
                }
                temp /= 10;
            }
            price += cnt;
            if (price > k) {
                break;
            }
            res = num;
            num++;
        }
        return res;
    }
}