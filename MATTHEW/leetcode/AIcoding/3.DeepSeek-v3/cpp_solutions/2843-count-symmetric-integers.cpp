class Solution {
public:
    int countSymmetricIntegers(int low, int high) {
        int count = 0;
        for (int num = low; num <= high; ++num) {
            string s = to_string(num);
            int n = s.size();
            if (n % 2 != 0) continue;
            int sum1 = 0, sum2 = 0;
            for (int i = 0; i < n / 2; ++i) {
                sum1 += s[i] - '0';
                sum2 += s[n - 1 - i] - '0';
            }
            if (sum1 == sum2) {
                ++count;
            }
        }
        return count;
    }
};