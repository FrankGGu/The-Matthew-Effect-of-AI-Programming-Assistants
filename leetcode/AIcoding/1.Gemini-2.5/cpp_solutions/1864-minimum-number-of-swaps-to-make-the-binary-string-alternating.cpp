#include <string>
#include <numeric>
#include <cmath>
#include <algorithm>

class Solution {
public:
    int minSwaps(std::string s) {
        int n = s.length();
        int ones = 0;
        int zeros = 0;
        for (char c : s) {
            if (c == '1') {
                ones++;
            } else {
                zeros++;
            }
        }

        if (std::abs(ones - zeros) > 1) {
            return -1;
        }

        if (n % 2 == 1) {
            if (ones > zeros) {
                // Target must be "10101..."
                int misplaced_zeros = 0;
                for (int i = 0; i < n; i += 2) {
                    if (s[i] == '0') {
                        misplaced_zeros++;
                    }
                }
                return misplaced_zeros;
            } else { // zeros > ones
                // Target must be "01010..."
                int misplaced_ones = 0;
                for (int i = 0; i < n; i += 2) {
                    if (s[i] == '1') {
                        misplaced_ones++;
                    }
                }
                return misplaced_ones;
            }
        } else { // n % 2 == 0
            // ones must be equal to zeros
            // Two possible targets: "0101..." and "1010..."

            // Calculate swaps for target "0101..."
            // This is the number of '1's at even positions
            int misplaced_ones_for_01 = 0;
            for (int i = 0; i < n; i += 2) {
                if (s[i] == '1') {
                    misplaced_ones_for_01++;
                }
            }

            // Swaps for target "1010..." is the number of '0's at even positions
            // which is (n/2) - misplaced_ones_for_01
            return std::min(misplaced_ones_for_01, n / 2 - misplaced_ones_for_01);
        }
    }
};