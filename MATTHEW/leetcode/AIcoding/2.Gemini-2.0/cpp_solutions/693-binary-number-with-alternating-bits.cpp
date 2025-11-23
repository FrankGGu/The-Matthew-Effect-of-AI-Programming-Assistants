class Solution {
public:
    bool hasAlternatingBits(int n) {
        int prevBit = -1;
        while (n > 0) {
            int currentBit = n % 2;
            if (currentBit == prevBit) {
                return false;
            }
            prevBit = currentBit;
            n /= 2;
        }
        return true;
    }
};