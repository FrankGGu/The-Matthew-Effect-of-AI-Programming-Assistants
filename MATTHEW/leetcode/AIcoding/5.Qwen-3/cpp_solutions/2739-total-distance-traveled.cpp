#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int totalDistanceTraveled(int capacity, vector<int> stations) {
        int total = 0;
        int current = 0;
        for (int i = 0; i < stations.size(); ++i) {
            if (current + stations[i] > capacity) {
                total += (current + stations[i]) - capacity;
                current = capacity;
            }
            current -= stations[i];
        }
        return total;
    }
};