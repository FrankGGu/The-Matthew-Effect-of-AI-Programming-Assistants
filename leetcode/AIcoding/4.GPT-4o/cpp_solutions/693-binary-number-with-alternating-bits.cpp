class Solution {
public:
    bool hasAlternatingBits(int n) {
        int prev_bit = n & 1;
        n >>= 1;
        while (n > 0) {
            int current_bit = n & 1;
            if (current_bit == prev_bit) {
                return false;
            }
            prev_bit = current_bit;
            n >>= 1;
        }
        return true;
    }
};