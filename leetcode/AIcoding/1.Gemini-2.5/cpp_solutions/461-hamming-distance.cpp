class Solution {
public:
    int hammingDistance(int x, int y) {
        int xor_val = x ^ y;
        int distance = 0;
        while (xor_val != 0) {
            distance++;
            xor_val &= (xor_val - 1);
        }
        return distance;
    }
};