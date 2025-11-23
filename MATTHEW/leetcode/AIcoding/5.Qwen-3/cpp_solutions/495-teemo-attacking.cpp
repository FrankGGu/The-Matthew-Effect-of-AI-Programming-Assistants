#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findPoisonedDuration(vector<int>& timeSeries, int duration) {
        if (timeSeries.empty() || duration == 0) {
            return 0;
        }
        int total = 0;
        for (int i = 1; i < timeSeries.size(); ++i) {
            total += min(timeSeries[i] - timeSeries[i - 1], duration);
        }
        total += duration;
        return total;
    }
};