class Solution {
public:
    int minimizeXor(int num1, int num2) {
        int bitsNum2 = __builtin_popcount(num2);
        int result = 0;
        for (int i = 30; i >= 0; --i) {
            if ((num1 & (1 << i)) && bitsNum2 > 0) {
                result |= (1 << i);
                bitsNum2--;
            }
        }
        for (int i = 0; i <= 30 && bitsNum2 > 0; ++i) {
            if (!(result & (1 << i))) {
                result |= (1 << i);
                bitsNum2--;
            }
        }
        return result;
    }
};