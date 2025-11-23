#include <vector>

using namespace std;

class Solution {
public:
    int maximumCandies(vector<int>& candies, long long k) {
        long long totalCandies = 0;
        for (int candy : candies) {
            totalCandies += candy;
        }
        if (totalCandies < k) {
            return 0;
        }

        int left = 1, right = *max_element(candies.begin(), candies.end());
        int ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            long long count = 0;
            for (int candy : candies) {
                count += candy / mid;
            }

            if (count >= k) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return ans;
    }
};