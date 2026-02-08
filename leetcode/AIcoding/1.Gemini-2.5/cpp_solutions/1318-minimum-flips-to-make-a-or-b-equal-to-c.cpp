class Solution {
public:
    int minFlips(int a, int b, int c) {
        int flips = 0;
        for (int i = 0; i < 31; ++i) {
            int bit_a = (a >> i) & 1;
            int bit_b = (b >> i) & 1;
            int bit_c = (c >> i) & 1;

            if ((bit_a | bit_b) == bit_c) {
                continue;
            } else {
                if (bit_c == 0) {
                    if (bit_a == 1) {
                        flips++;
                    }
                    if (bit_b == 1) {
                        flips++;
                    }
                } else { // bit_c == 1
                    flips++;
                }
            }
        }
        return flips;
    }
};