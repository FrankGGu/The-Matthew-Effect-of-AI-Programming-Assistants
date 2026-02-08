#include <string>
#include <vector>
#include <numeric>
#include <cmath>

class Solution {
public:
    bool sumGame(std::string num) {
        int n = num.length();
        int s1 = 0, q1 = 0; // sum and question mark count for first half
        int s2 = 0, q2 = 0; // sum and question mark count for second half

        for (int i = 0; i < n / 2; ++i) {
            if (num[i] == '?') {
                q1++;
            } else {
                s1 += (num[i] - '0');
            }
        }

        for (int i = n / 2; i < n; ++i) {
            if (num[i] == '?') {
                q2++;
            } else {
                s2 += (num[i] - '0');
            }
        }

        int diff_sum = s1 - s2;
        int diff_q = q1 - q2;

        // If diff_q is odd, Alice can always make the final sum non-zero.
        // The expression (2 * diff_sum + diff_q * 9) will be odd, hence never 0.
        if (diff_q % 2 != 0) {
            return true; // Alice wins
        } else {
            // If diff_q is even, then Alice and Bob make an equal number of "effective" moves
            // on the unbalanced question marks.
            // The condition for Bob to win is that the initial difference,
            // combined with the average value of the "unbalanced" question marks, sums to zero.
            // Each unbalanced '?' effectively contributes 4.5 to the sum difference.
            // So, diff_sum + diff_q * 4.5 == 0
            // Multiply by 2 to avoid floating point: 2 * diff_sum + diff_q * 9 == 0
            if (2 * diff_sum + diff_q * 9 == 0) {
                return false; // Bob wins
            } else {
                return true; // Alice wins
            }
        }
    }
};