#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minFlips(std::string s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        std::string s_ext = s + s;
        int min_flips_count = n; 

        int flips_to_0101 = 0; // flips needed for "0101..." pattern
        int flips_to_1010 = 0; // flips needed for "1010..." pattern

        // Calculate flips for the initial window s_ext[0...n-1]
        for (int j = 0; j < n; ++j) {
            // Character at absolute index j in s_ext
            // For "0101..." pattern, expected char is '0' if j is even, '1' if j is odd
            if (s_ext[j] != (j % 2 == 0 ? '0' : '1')) {
                flips_to_0101++;
            }
            // For "1010..." pattern, expected char is '1' if j is even, '0' if j is odd
            if (s_ext[j] != (j % 2 == 0 ? '1' : '0')) {
                flips_to_1010++;
            }
        }
        min_flips_count = std::min(flips_to_0101, flips_to_1010);

        // Slide the window
        // 'i' represents the starting absolute index of the current window in s_ext.
        // The window spans from s_ext[i] to s_ext[i+n-1].
        // We iterate 'i' from 1 to n-1 to cover all 'n' possible shifts.
        for (int i = 1; i < n; ++i) {
            // Character s_ext[i-1] is leaving the window.
            // Its contribution to flip counts, based on its absolute index (i-1), must be removed.
            if (s_ext[i-1] != ((i-1) % 2 == 0 ? '0' : '1')) {
                flips_to_0101--;
            }
            if (s_ext[i-1] != ((i-1) % 2 == 0 ? '1' : '0')) {
                flips_to_1010--;
            }

            // Character s_ext[i+n-1] is entering the window.
            // Its contribution to flip counts, based on its absolute index (i+n-1), must be added.
            if (s_ext[i+n-1] != ((i+n-1) % 2 == 0 ? '0' : '1')) {
                flips_to_0101++;
            }
            if (s_ext[i+n-1] != ((i+n-1) % 2 == 0 ? '1' : '0')) {
                flips_to_1010++;
            }

            min_flips_count = std::min(min_flips_count, std::min(flips_to_0101, flips_to_1010));
        }

        return min_flips_count;
    }
};