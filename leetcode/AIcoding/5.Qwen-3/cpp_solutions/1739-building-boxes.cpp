#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minBoxes(vector<int>& capacities) {
        sort(capacities.begin(), capacities.end());
        int boxes = 0;
        int current = 0;
        for (int cap : capacities) {
            if (current < cap) {
                boxes++;
                current = cap;
            } else {
                current -= cap;
            }
        }
        return boxes;
    }
};