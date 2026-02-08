class Solution {
public:
    int sumEncrypted(int n) {
        int sum = 0;
        for (int i = 1; i <= n; ++i) {
            sum += i ^ (i + 1);
        }
        return sum;
    }
};