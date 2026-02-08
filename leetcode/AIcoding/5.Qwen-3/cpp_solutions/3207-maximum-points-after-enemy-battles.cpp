#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPoints(vector<int>& enemyEnergies, int currentEnergy) {
        sort(enemyEnergies.begin(), enemyEnergies.end());
        int points = 0;
        for (int energy : enemyEnergies) {
            if (currentEnergy > energy) {
                points++;
                currentEnergy += 1;
            }
        }
        return points;
    }
};