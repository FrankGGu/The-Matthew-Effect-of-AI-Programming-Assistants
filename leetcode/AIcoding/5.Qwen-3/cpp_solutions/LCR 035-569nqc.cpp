#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int findMinDifference(vector<string>& timePoints) {
        int n = timePoints.size();
        vector<int> times(n);

        for (int i = 0; i < n; ++i) {
            string& t = timePoints[i];
            int hours = stoi(t.substr(0, 2));
            int minutes = stoi(t.substr(3, 2));
            times[i] = hours * 60 + minutes;
        }

        sort(times.begin(), times.end());

        int minDiff = INT_MAX;
        for (int i = 0; i < n; ++i) {
            int diff = times[(i + 1) % n] - times[i];
            if (diff > 720) {
                diff -= 1440;
            }
            minDiff = min(minDiff, diff);
        }

        return minDiff;
    }
};