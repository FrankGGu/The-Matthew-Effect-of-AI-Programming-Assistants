#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int minEatingSpeed(vector<int>& piles, int h) {
        int left = 1;
        int right = *max_element(piles.begin(), piles.end());

        while (left < right) {
            int mid = left + (right - left) / 2;
            long long hours = 0;

            for (int pile : piles) {
                hours += ceil(static_cast<double>(pile) / mid);
            }

            if (hours > h) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    }
};