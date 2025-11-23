#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minEatingSpeed(vector<int>& piles, int h) {
        long long left = 1;
        long long right = *max_element(piles.begin(), piles.end());

        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long hours = 0;
            for (int pile : piles) {
                hours += (pile + mid - 1) / mid;
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