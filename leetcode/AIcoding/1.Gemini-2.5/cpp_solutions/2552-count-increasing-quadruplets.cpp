#include <vector>
#include <numeric>

class Solution {
public:
    long long countIncreasingQuadruplets(std::vector<int>& nums) {
        int n = nums.size();
        long long total_quadruplets = 0;

        // left_smaller[j][val] stores the count of elements nums[i] such that i < j and nums[i] < val.
        // The maximum possible value for nums[x] is n. So, the second dimension size is n + 1.
        std::vector<std::vector<int>> left_smaller(n, std::vector<int>(n + 1, 0));

        // Precompute left_smaller
        // left_smaller[j] represents counts for elements nums[0...j-1]
        for (int j = 1; j < n; ++j) {
            // Copy counts from the previous index j-1
            for (int val = 1; val <= n; ++val) {
                left_smaller[j][val] = left_smaller[j-1][val];
            }
            // Increment counts for values greater than nums[j-1]
            // For any val > nums[j-1], nums[j-1] contributes to left_smaller[j][val]
            for (int val = nums[j-1] + 1; val <= n; ++val) {
                left_smaller[j][val]++;
            }
        }

        // right_greater[k][val] stores the count of elements nums[l] such that l > k and nums[l] > val.
        // The maximum possible value for nums[x] is n. So, the second dimension size is n + 1.
        std::vector<std::vector<int>> right_greater(n, std::vector<int>(n + 1, 0));

        // Precompute right_greater
        // right_greater[k] represents counts for elements nums[k+1...n-1]
        for (int k = n - 2; k >= 0; --k) {
            // Copy counts from the next index k+1
            for (int val = 1; val <= n; ++val) {
                right_greater[k][val] = right_greater[k+1][val];
            }
            // Increment counts for values smaller than nums[k+1]
            // For any val < nums[k+1], nums[k+1] contributes to right_greater[k][val]
            for (int val = 1; val < nums[k+1]; ++val) {
                right_greater[k][val]++;
            }
        }

        // Iterate through all possible pairs (j, k) such that i < j < k < l
        // j can range from 1 to n-3
        // k can range from j+1 to n-2
        for (int j = 1; j < n - 2; ++j) {
            for (int k = j + 1; k < n - 1; ++k) {
                // Condition: nums[i] < nums[k] < nums[j] < nums[l]
                // We fix j and k, and need to satisfy nums[k] < nums[j]
                if (nums[k] < nums[j]) {
                    // Count i's: number of elements nums[i] such that i < j and nums[i] < nums[k]
                    long long count_i = left_smaller[j][nums[k]];

                    // Count l's: number of elements nums[l] such that l > k and nums[l] > nums[j]
                    long long count_l = right_greater[k][nums[j]];

                    total_quadruplets += count_i * count_l;
                }
            }
        }

        return total_quadruplets;
    }
};