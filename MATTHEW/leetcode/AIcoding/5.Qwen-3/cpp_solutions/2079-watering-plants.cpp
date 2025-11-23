#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int wateringPlants(vector<int>& plants, int capacity) {
        int steps = 0;
        int currentCapacity = capacity;
        for (int i = 0; i < plants.size(); ++i) {
            if (currentCapacity < plants[i]) {
                steps += 2 * i;
                currentCapacity = capacity;
            }
            steps++;
            currentCapacity -= plants[i];
        }
        return steps;
    }
};