#include <vector>
#include <algorithm>

class Solution {
public:
    int countRangeSum(std::vector<int>& nums, int lower, int upper) {
        int n = nums.size();
        std::vector<long long> prefix_sums(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_sums[i + 1] = prefix_sums[i] + nums[i];
        }
        return mergeSortAndCount(prefix_sums, 0, n + 1, lower, upper);
    }

private:
    int mergeSortAndCount(std::vector<long long>& sums, int start, int end, int lower, int upper) {
        if (end - start <= 1) {
            return 0;
        }

        int mid = start + (end - start) / 2;
        int count = mergeSortAndCount(sums, start, mid, lower, upper) + 
                    mergeSortAndCount(sums, mid, end, lower, upper);

        int l = mid;
        int r = mid;
        for (int i = start; i < mid; ++i) {
            while (l < end && sums[l] - sums[i] < lower) {
                l++;
            }
            while (r < end && sums[r] - sums[i] <= upper) {
                r++;
            }
            count += r - l;
        }

        std::inplace_merge(sums.begin() + start, sums.begin() + mid, sums.begin() + end);

        return count;
    }
};