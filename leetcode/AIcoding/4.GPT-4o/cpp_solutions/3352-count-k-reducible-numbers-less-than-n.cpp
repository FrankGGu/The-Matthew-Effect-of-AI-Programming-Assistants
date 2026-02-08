class Solution {
public:
    int countKReducibleNumbers(int n, int k) {
        int count = 0;
        for (int i = 1; i < n; ++i) {
            int temp = i, sum = 0;
            while (temp > 0) {
                sum += temp % 10;
                temp /= 10;
            }
            if (sum % k == 0) {
                count++;
            }
        }
        return count;
    }
};