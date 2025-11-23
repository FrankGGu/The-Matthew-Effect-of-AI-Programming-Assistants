#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int findClosestPlayer(vector<int>& people, int target) {
        int closestIndex = -1;
        int minDistance = INT_MAX;

        for (int i = 0; i < people.size(); ++i) {
            if (people[i] == target) {
                return i;
            }
            int distance = abs(people[i] - target);
            if (distance < minDistance) {
                minDistance = distance;
                closestIndex = i;
            }
        }

        return closestIndex;
    }
};