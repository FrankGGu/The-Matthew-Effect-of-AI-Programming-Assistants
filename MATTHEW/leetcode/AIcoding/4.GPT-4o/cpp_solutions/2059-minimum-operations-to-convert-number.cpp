class Solution {
public:
    int minOperations(int n) {
        int ops = 0;
        while (n > 0) {
            ops += n % 2;
            n /= 2;
        }
        return ops;
    }
};