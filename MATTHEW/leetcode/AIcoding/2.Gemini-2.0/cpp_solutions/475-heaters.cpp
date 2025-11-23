#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findRadius(vector<int>& houses, vector<int>& heaters) {
        sort(houses.begin(), houses.end());
        sort(heaters.begin(), heaters.end());

        int radius = 0;
        for (int house : houses) {
            int left = 0;
            int right = heaters.size() - 1;
            int minRadius = INT_MAX;

            while (left <= right) {
                int mid = left + (right - left) / 2;
                int dist = abs(heaters[mid] - house);

                minRadius = min(minRadius, dist);

                if (heaters[mid] < house) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            if (left > 0) {
                minRadius = min(minRadius, abs(heaters[left - 1] - house));
            }

            radius = max(radius, minRadius);
        }

        return radius;
    }
};