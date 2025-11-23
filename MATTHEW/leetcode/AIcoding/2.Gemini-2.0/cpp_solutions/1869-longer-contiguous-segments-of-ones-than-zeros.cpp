class Solution {
public:
    bool checkZeroOnes(string s) {
        int max_ones = 0, max_zeros = 0;
        int current_ones = 0, current_zeros = 0;

        for (char c : s) {
            if (c == '1') {
                current_ones++;
                current_zeros = 0;
                max_ones = max(max_ones, current_ones);
            } else {
                current_zeros++;
                current_ones = 0;
                max_zeros = max(max_zeros, current_zeros);
            }
        }

        return max_ones > max_zeros;
    }
};