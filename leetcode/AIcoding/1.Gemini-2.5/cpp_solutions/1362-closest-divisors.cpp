#include <vector>
#include <cmath>
#include <algorithm> // For std::abs

class Solution {
public:
    std::vector<int> closestDivisors(int num) {
        int target1 = num + 1;
        int target2 = num + 2;

        int min_diff = 2000000000; // Initialize with a sufficiently large value
        std::vector<int> result(2);

        // Lambda function to find the closest divisors for a given target number
        // and update the global min_diff and result if a better pair is found.
        auto find_best_pair = [&](int target) {
            // Iterate downwards from the square root of the target.
            // The first pair (i, target/i) found will have the minimum absolute difference.
            for (int i = static_cast<int>(sqrt(target)); i >= 1; --i) {
                if (target % i == 0) {
                    int j = target / i;
                    if (std::abs(i - j) < min_diff) {
                        min_diff = std::abs(i - j);
                        result[0] = i;
                        result[1] = j;
                    }
                    return; // Found the closest pair for this target, no need to check further
                }
            }
        };

        find_best_pair(target1);
        find_best_pair(target2);

        return result;
    }
};