#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int carFleet(int target, vector<int>& position, vector<int>& speed) {
        vector<pair<int, double>> cars;
        for (int i = 0; i < position.size(); ++i) {
            double time = static_cast<double>(target - position[i]) / speed[i];
            cars.emplace_back(position[i], time);
        }

        sort(cars.begin(), cars.end());

        int fleets = 0;
        double current_time = 0.0;

        for (int i = cars.size() - 1; i >= 0; --i) {
            if (cars[i].second > current_time) {
                fleets++;
                current_time = cars[i].second;
            }
        }

        return fleets;
    }
};