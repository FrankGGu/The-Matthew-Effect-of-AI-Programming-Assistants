#include <vector>
#include <algorithm>

class Solution {
public:
    int maxCandies(std::vector<int>& candies, int k) {
        int left = 1, right = *std::max_element(candies.begin(), candies.end());
        int result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int count = 0;

            for (int candy : candies) {
                count += candy / mid;
            }

            if (count >= k) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }
};