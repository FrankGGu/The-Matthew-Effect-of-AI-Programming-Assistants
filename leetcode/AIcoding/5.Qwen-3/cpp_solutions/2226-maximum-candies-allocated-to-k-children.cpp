#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxCandies(vector<int>& candies, int k) {
        long long left = 0;
        long long right = *max_element(candies.begin(), candies.end());
        long long result = 0;

        while (left <= right) {
            long long mid = left + (right - left) / 2;
            long long count = 0;

            for (int c : candies) {
                count += c / mid;
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