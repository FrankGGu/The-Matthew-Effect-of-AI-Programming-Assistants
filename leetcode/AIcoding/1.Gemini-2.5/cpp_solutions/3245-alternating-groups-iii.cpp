#include <iostream>
#include <vector>
#include <numeric>

class Solution {
public:
    long long countAlternatingSubarrays(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }
        long long total_count = 0;
        long long current_streak = 0;

        total_count = 1;
        current_streak = 1;

        for (int i = 1; i < n; ++i) {
            if (nums[i] != nums[i - 1]) {
                current_streak++;
            } else {
                current_streak = 1;
            }
            total_count += current_streak;
        }

        return total_count;
    }
};

class Solution {
public:
    int numberOfAlternatingGroups(std::vector<int>& colors, int k) {
        int n = colors.size();
        std::vector<int> extended_colors = colors;
        for (int i = 0; i < k - 1; ++i) {
            extended_colors.push_back(colors[i]);
        }

        int bad_pairs = 0;
        for (int i = 0; i < k - 1; ++i) {
            if (extended_colors[i] == extended_colors[i + 1]) {
                bad_pairs++;
            }
        }

        int result = 0;
        if (bad_pairs == 0) {
            result++;
        }

        for (int i = 1; i < n; ++i) {
            if (extended_colors[i - 1] == extended_colors[i]) {
                bad_pairs--;
            }
            if (extended_colors[i + k - 2] == extended_colors[i + k - 1]) {
                bad_pairs++;
            }
            if (bad_pairs == 0) {
                result++;
            }
        }

        return result;
    }
};