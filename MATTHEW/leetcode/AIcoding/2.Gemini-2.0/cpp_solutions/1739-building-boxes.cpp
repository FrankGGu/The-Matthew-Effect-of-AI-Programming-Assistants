class Solution {
public:
    int minimumBoxes(int n) {
        long long k = 0;
        while (n > 0) {
            k++;
            long long sum = k * (k + 1) / 2;
            if (sum > n) {
                k--;
                break;
            }
        }
        n -= k * (k + 1) / 2;
        long long l = 0;
        while (n > 0) {
            l++;
            if (l > n) {
                l--;
                break;
            }
            n -= l;
        }
        return k * (k + 1) / 2 + l;
    }
};