#include <vector>
#include <unordered_set>
#include <algorithm> // Required for std::sort if using the set<vector<int>> approach, but not for the optimized counting.

class Solution {
public:
    long long numberOfUniqueXORTriplets(std::vector<int>& nums) {
        // Step 1: Extract unique elements from nums and store them in a vector and a hash set for efficient lookup.
        // The unordered_set ensures we only consider unique values from the input array.
        std::unordered_set<int> unique_elements_set;
        for (int x : nums) {
            unique_elements_set.insert(x);
        }

        // Convert the set of unique elements to a vector for indexed iteration.
        std::vector<int> unique_elements_vec;
        for (int x : unique_elements_set) {
            unique_elements_vec.push_back(x);
        }

        long long count = 0;
        int N = unique_elements_vec.size();

        // Step 2: Iterate through all possible pairs (a, b) from unique_elements_vec.
        // We use nested loops to pick 'a' and 'b'.
        // The outer loop picks 'a'.
        for (int i = 0; i < N; ++i) {
            int a = unique_elements_vec[i];
            // The inner loop picks 'b'. We start 'j' from 'i' to ensure 'a <= b'.
            // This handles cases where 'a' and 'b' can be the same value, and avoids
            // redundant checks for (b, a) if (a, b) has already been considered.
            for (int j = i; j < N; ++j) {
                int b = unique_elements_vec[j];

                // Calculate the required third element 'c' such that a ^ b ^ c = 0.
                // This implies c = a ^ b.
                int c = a ^ b;

                // Step 3: Check if 'c' exists in our set of unique elements.
                if (unique_elements_set.count(c)) {
                    // We have a candidate triplet (a, b, c) where a, b, c are values from nums.
                    // To count each unique set of values {a, b, c} exactly once, we enforce a canonical order: a <= b <= c.
                    // Due to the loop structure (j starting from i), we already have a <= b.
                    // We now add a condition to ensure b <= c.
                    // This ensures that for any unique set {x, y, z} with x <= y <= z, it will be counted only when
                    // 'a' is chosen as 'x', 'b' as 'y', and 'c' as 'z' during the iteration.
                    if (b <= c) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
};