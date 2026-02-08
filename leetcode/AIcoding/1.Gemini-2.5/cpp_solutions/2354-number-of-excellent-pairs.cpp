#include <vector>
#include <set>
#include <numeric> // For __builtin_popcount, though often implicitly available

class Solution {
public:
    long long excellentPairs(std::vector<int>& nums, int k) {
        // Use a set to get unique numbers from the input array.
        // This ensures that each distinct number is considered only once
        // when calculating its set bit count.
        std::set<int> unique_nums_set(nums.begin(), nums.end());

        // Create a frequency array to store the count of unique numbers
        // that have a certain number of set bits.
        // The maximum number of set bits for an integer up to 10^9 is 30.
        // So, an array of size 31 (indices 0 to 30) is sufficient.
        std::vector<int> freq(31, 0); 
        for (int num : unique_nums_set) {
            // __builtin_popcount is a GCC extension that counts the number of set bits (1s)
            // in an unsigned integer. LeetCode's environment supports it.
            freq[__builtin_popcount(num)]++;
        }

        long long ans = 0;

        // Iterate through all possible pairs of set bit counts (bc1, bc2).
        // Both bc1 and bc2 can range from 0 to 30.
        for (int bc1 = 0; bc1 <= 30; ++bc1) {
            for (int bc2 = 0; bc2 <= 30; ++bc2) {
                // If the sum of the set bit counts is greater than or equal to k,
                // then any pair (a, b) where 'a' has bc1 set bits and 'b' has bc2 set bits
                // forms an excellent pair.
                if (bc1 + bc2 >= k) {
                    // The number of choices for 'a' is freq[bc1].
                    // The number of choices for 'b' is freq[bc2].
                    // The total number of such pairs (a, b) is freq[bc1] * freq[bc2].
                    // This correctly handles:
                    // 1. (a, b) and (b, a) as distinct pairs if a != b.
                    // 2. (a, a) as a single pair if a == b.
                    // For example, if freq[bc1]=X and freq[bc2]=Y:
                    // - If bc1 != bc2, we count X*Y pairs.
                    // - If bc1 == bc2, we count X*X pairs. This includes X pairs of type (a,a)
                    //   and X*(X-1) pairs of type (a,b) where a!=b, effectively counting (a,b) and (b,a) distinctly.
                    ans += (long long)freq[bc1] * freq[bc2];
                }
            }
        }

        return ans;
    }
};