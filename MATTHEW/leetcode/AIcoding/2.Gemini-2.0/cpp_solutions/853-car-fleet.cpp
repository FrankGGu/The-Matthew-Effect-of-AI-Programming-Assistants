#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int carFleet(int target, vector<int>& position, vector<int>& speed) {
        int n = position.size();
        vector<pair<int, double>> cars;
        for (int i = 0; i < n; ++i) {
            cars.push_back({position[i], (double)(target - position[i]) / speed[i]});
        }

        sort(cars.begin(), cars.end());

        int fleets = 0;
        double maxTime = 0;
        for (int i = n - 1; i >= 0; --i) {
            if (cars[i].second > maxTime) {
                fleets++;
                maxTime = cars[i].second;
            }
        }

        return fleets;
    }
};