#include <algorithm> // Required for std::min

class Solution {
public:
    long long longestString(int x, int y, int z) {
        long long ans = 0;

        // All 'AB' strings can be used without violating the 'AAA' or 'BBB' rule.
        // Each 'AB' string contributes 2 to the length.
        ans += (long long)z * 2;

        // For 'AA' and 'BB' strings, we must alternate them to avoid 'AAA' or 'BBB' substrings.
        // We can form std::min(x, y) pairs of 'AA' and 'BB' strings, e.g., "AA BB AA BB ...".
        // This uses std::min(x, y) 'AA' strings and std::min(x, y) 'BB' strings.
        // Each such string ('AA' or 'BB') contributes 2 to the length.
        // So, these alternating pairs contribute 2 * std::min(x, y) * 2 to the length.
        ans += (long long)std::min(x, y) * 2; // For the 'AA' blocks in the alternating sequence
        ans += (long long)std::min(x, y) * 2; // For the 'BB' blocks in the alternating sequence

        // After forming the alternating pairs, we are left with std::abs(x - y) strings
        // of the majority type (either 'AA' or 'BB').
        // We can append one more string of the majority type to the alternating sequence.
        // For example, if x > y, the sequence ends with 'BB'. We can append one 'AA'
        // (e.g., "...BB AA") without creating "AAA" or "BBB". This adds 2 to the length.
        // If x == y, there are no remaining strings of a majority type, so we add 0.
        if (x != y) {
            ans += 2;
        }

        return ans;
    }
};