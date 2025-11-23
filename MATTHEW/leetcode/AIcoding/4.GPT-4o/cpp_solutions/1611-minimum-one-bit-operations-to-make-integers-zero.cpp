class Solution {
public:
    int minimumOneBitOperations(int n) {
        int res = 0, bit = 1;
        while (bit <= n) {
            bit <<= 1;
        }
        while (bit > 0) {
            if (n & bit) {
                res ^= (bit - 1);
                n ^= bit;
            }
            bit >>= 1;
        }
        return res;
    }
};