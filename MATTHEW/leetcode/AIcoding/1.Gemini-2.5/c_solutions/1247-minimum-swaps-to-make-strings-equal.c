#include <string.h>

int minimumSwap(char * s1, char * s2){
    int count_xy = 0; // Number of positions where s1[i] = 'x' and s2[i] = 'y'
    int count_yx = 0; // Number of positions where s1[i] = 'y' and s2[i] = 'x'

    int n = strlen(s1);

    for (int i = 0; i < n; i++) {
        if (s1[i] == s2[i]) {
            continue;
        }
        if (s1[i] == 'x' && s2[i] == 'y') {
            count_xy++;
        } else { // s1[i] == 'y' && s2[i] == 'x'
            count_yx++;
        }
    }

    // For the strings to become equal, the total count of 'x's and 'y's across both strings
    // must be even. A swap s1[i] <-> s2[j] preserves these total counts.
    // The total count of 'x's (and 'y's) is even if and only if (count_xy + count_yx) is even.
    // If (count_xy + count_yx) is odd, it's impossible to make the strings equal.
    if ((count_xy + count_yx) % 2 != 0) {
        return -1;
    }

    int swaps = 0;

    // Each pair of 'xy' mismatches can be resolved in 1 swap.
    // Example: s1="xx", s2="yy". Mismatches: (s1[0]='x', s2[0]='y'), (s1[1]='x', s2[1]='y')
    // Swap s1[0] and s2[1]: s1 becomes "yx", s2 becomes "yx". 1 swap.
    // This fixes two 'xy' mismatches.
    swaps += count_xy / 2;

    // Each pair of 'yx' mismatches can be resolved in 1 swap.
    // Example: s1="yy", s2="xx". Mismatches: (s1[0]='y', s2[0]='x'), (s1[1]='y', s2[1]='x')
    // Swap s1[0] and s2[1]: s1 becomes "xy", s2 becomes "xy". 1 swap.
    // This fixes two 'yx' mismatches.
    swaps += count_yx / 2;

    // After resolving pairs, if count_xy was odd, one 'xy' mismatch remains.
    // If count_yx was odd, one 'yx' mismatch remains.
    // Due to the initial check ((count_xy + count_yx) % 2 != 0), if count_xy is odd,
    // then count_yx must also be odd.
    // In this case, we are left with one 'xy' mismatch (e.g., s1[a]='x', s2[a]='y')
    // and one 'yx' mismatch (e.g., s1[b]='y', s2[b]='x').
    // These two remaining mismatches require 2 additional swaps to resolve.
    //
    // Consider s1="xy", s2="yx".
    // 1. Swap s1[0] and s2[0] (conceptual: s1[0] becomes 'y', s2[0] becomes 'x').
    //    s1 becomes "yy", s2 becomes "xx". (This is 1 swap, but changes 'xy' to 'yx').
    //    Now we have two 'yx' mismatches: (s1[0]='y', s2[0]='x') and (s1[1]='y', s2[1]='x').
    // 2. Swap s1[0] and s2[1] (fixes both 'yx' mismatches).
    //    s1 becomes "xy", s2 becomes "xy". (This is 1 more swap).
    // Total 2 swaps.
    // The problem states i != j for swaps. This is satisfied in the second swap.
    // The first swap (s1[0] <-> s2[0]) is not directly allowed. However, it can be simulated
    // by two i!=j swaps: swap s1[a] with s1[b], then swap s1[a] with s2[a].
    // Or more directly:
    // 1. Swap s1[a] ('x') with s2[a] ('y') (conceptual, results in s1[a]='y', s2[a]='x').
    //    This turns an 'xy' mismatch into a 'yx' mismatch.
    //    Now we have two 'yx' mismatches (at 'a' and 'b').
    // 2. Swap s1[a] ('y') with s2[b] ('x'). This resolves both 'yx' mismatches.
    // This requires 2 swaps.
    if (count_xy % 2 == 1) { 
        swaps += 2;
    }

    return swaps;
}