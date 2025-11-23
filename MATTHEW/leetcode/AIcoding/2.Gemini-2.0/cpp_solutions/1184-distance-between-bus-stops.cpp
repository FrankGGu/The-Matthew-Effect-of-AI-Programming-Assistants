#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int distanceBetweenBusStops(vector<int>& distance, int start, int destination) {
        int n = distance.size();
        int totalSum = accumulate(distance.begin(), distance.end(), 0);
        int clockwiseSum = 0;
        int i = start;
        while (i != destination) {
            clockwiseSum += distance[i];
            i = (i + 1) % n;
        }
        return min(clockwiseSum, totalSum - clockwiseSum);
    }
};