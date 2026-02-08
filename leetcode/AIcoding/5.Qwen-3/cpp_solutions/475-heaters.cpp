#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int findRadius(std::vector<int>& houses, std::vector<int>& heaters) {
        std::sort(heaters.begin(), heaters.end());
        int result = 0;
        for (int house : houses) {
            int left = 0, right = heaters.size() - 1;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (heaters[mid] < house) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            int dist = std::abs(heaters[left] - house);
            result = std::max(result, dist);
        }
        return result;
    }
};