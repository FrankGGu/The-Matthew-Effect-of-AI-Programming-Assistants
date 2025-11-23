#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> mostVisited(int n, std::vector<int>& rounds) {
        std::vector<int> result;
        int start = rounds[0];
        int end = rounds[rounds.size() - 1];

        if (start <= end) {
            for (int i = start; i <= end; ++i) {
                result.push_back(i);
            }
        } else { // start > end, path wraps around
            // Sectors from 1 to end
            for (int i = 1; i <= end; ++i) {
                result.push_back(i);
            }
            // Sectors from start to n
            for (int i = start; i <= n; ++i) {
                result.push_back(i);
            }
        }

        // The problem statement implies the result should be sorted.
        // The loops above already produce a sorted result for both cases:
        // For start <= end: [start, start+1, ..., end] is sorted.
        // For start > end: [1, ..., end, start, ..., n] is sorted (since end < start).

        return result;
    }
};