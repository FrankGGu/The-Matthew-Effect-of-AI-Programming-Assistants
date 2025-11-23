class Solution {
public:
    int wateringPlants(vector<int>& plants, int capacity) {
        int totalSteps = 0, currentWater = capacity;
        for (int i = 0; i < plants.size(); ++i) {
            if (currentWater < plants[i]) {
                totalSteps += i * 2; // return to the river
                currentWater = capacity; // refill
            }
            totalSteps++; // water the plant
            currentWater -= plants[i];
        }
        return totalSteps;
    }
};