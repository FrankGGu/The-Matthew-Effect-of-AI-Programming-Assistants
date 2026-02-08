#include <string>
#include <numeric>

class Solution {
public:
    int minimumSwaps(std::string s1, std::string s2) {
        int count_xy = 0; // Number of positions where s1[i] = 'x' and s2[i] = 'y'
        int count_yx = 0; // Number of positions where s1[i] = 'y' and s2[i] = 'x'

        for (int i = 0; i < s1.length(); ++i) {
            if (s1[i] == s2[i]) {
                continue; // Characters already match at this position, no swap needed
            }
            if (s1[i] == 'x' && s2[i] == 'y') {
                count_xy++;
            } else { // s1[i] == 'y' && s2[i] == 'x'
                count_yx++;
            }
        }

        // For s1 and s2 to become equal, the total count of 'x's across both strings
        // must be even, and similarly for 'y's.
        // The total number of 'x's is (count_xy + matched_x) + (count_yx + matched_x) = count_xy + count_yx + 2 * matched_x.
        // The total number of 'y's is (count_yx + matched_y) + (count_xy + matched_y) = count_xy + count_yx + 2 * matched_y.
        // For these totals to be even, (count_xy + count_yx) must be even.
        // If (count_xy + count_yx) is odd, it's impossible to make strings equal.
        if ((count_xy + count_yx) % 2 != 0) {
            return -1;
        }

        int swaps = 0;

        // Each pair of 'xy' mismatches can be resolved in 1 swap.
        // Example: s1 = "xx", s2 = "yy"
        // At index 0: s1[0]='x', s2[0]='y'
        // At index 1: s1[1]='x', s2[1]='y'
        // Swap s1[0] with s2[1].
        // s1 becomes "yx", s2 becomes "yx". Both are equal. 1 swap.
        swaps += count_xy / 2;

        // Each pair of 'yx' mismatches can be resolved in 1 swap.
        // Example: s1 = "yy", s2 = "xx"
        // At index 0: s1[0]='y', s2[0]='x'
        // At index 1: s1[1]='y', s2[1]='x'
        // Swap s1[0] with s2[1].
        // s1 becomes "xy", s2 becomes "xy". Both are equal. 1 swap.
        swaps += count_yx / 2;

        // If after pairing, there is one 'xy' mismatch left (meaning count_xy was odd)
        // and one 'yx' mismatch left (meaning count_yx was odd),
        // these two remaining mismatches require 2 swaps to resolve.
        // Example: s1 = "xy", s2 = "yx"
        // At index 0: s1[0]='x', s2[0]='y' (type 'xy')
        // At index 1: s1[1]='y', s2[1]='x' (type 'yx')
        //
        // Swap 1: Swap s1[0] with s2[0].
        // s1 becomes "yy", s2 becomes "xx".
        // Now at index 0: s1[0]='y', s2[0]='x' (type 'yx')
        // Now at index 1: s1[1]='y', s2[1]='x' (type 'yx')
        // We now have two 'yx' mismatches.
        //
        // Swap 2: Swap s1[0] with s2[1].
        // s1 becomes "xy", s2 becomes "xy". Both are equal.
        // Total 2 swaps for this remaining pair.
        if (count_xy % 2 == 1) { 
            // If count_xy is odd, then count_yx must also be odd because their sum is even.
            swaps += 2;
        }

        return swaps;
    }
};