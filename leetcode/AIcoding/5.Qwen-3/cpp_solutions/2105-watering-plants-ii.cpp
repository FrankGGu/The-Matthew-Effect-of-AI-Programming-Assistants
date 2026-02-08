#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int wateringPlants(vector<int>& plants, vector<int>& capacity) {
        int totalSteps = 0;
        int currentCapacity = capacity[0];
        int n = plants.size();

        for (int i = 0; i < n; ++i) {
            if (currentCapacity < plants[i]) {
                totalSteps += 2 * i;
                currentCapacity = capacity[0];
            }
            totalSteps += 1;
            currentCapacity -= plants[i];
        }

        return totalSteps;
    }
};