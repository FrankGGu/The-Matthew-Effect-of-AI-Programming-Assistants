#include <vector>

using namespace std;

class Solution {
public:
    int wateringPlants(vector<int>& plants, int capacityA, int capacityB) {
        int n = plants.size();
        int a = capacityA, b = capacityB;
        int steps = 0;
        int i = 0, j = n - 1;

        while (i < j) {
            if (a >= plants[i]) {
                a -= plants[i];
                steps++;
            } else {
                a = capacityA;
                steps += 1;
                a -= plants[i];
            }

            if (b >= plants[j]) {
                b -= plants[j];
                steps++;
            } else {
                b = capacityB;
                steps += 1;
                b -= plants[j];
            }

            i++;
            j--;
        }

        if (i == j) {
            if (a >= plants[i] || b >= plants[i]) {
                steps++;
            } else {
                steps += 1;
            }
        }

        return steps;
    }
};