class Solution {
public:
    int minimizeXor(int num1, int num2) {
        int count = __builtin_popcount(num2);
        int result = 0, bits = 0;

        for (int i = 31; i >= 0; --i) {
            if (num1 & (1 << i)) {
                result |= (1 << i);
                bits++;
            }
        }

        for (int i = 0; i < 32 && bits < count; ++i) {
            if (!(result & (1 << i))) {
                result |= (1 << i);
                bits++;
            }
        }

        return result;
    }
};