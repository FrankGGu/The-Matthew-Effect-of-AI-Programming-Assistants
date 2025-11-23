#include <vector>

using namespace std;

class Solution {
public:
    int wateringPlants(vector<int>& plants, int capacity) {
        int steps = 0;
        int currentCapacity = capacity;
        for (int i = 0; i < plants.size(); ++i) {
            if (currentCapacity >= plants[i]) {
                steps++;
                currentCapacity -= plants[i];
            } else {
                steps += i;
                steps += i + 1;
                currentCapacity = capacity - plants[i];
            }
        }
        return steps;
    }
};