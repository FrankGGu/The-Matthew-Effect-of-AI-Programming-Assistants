#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int findMinDifference(vector<string>& timePoints) {
        vector<int> minutes;
        for (const string& time : timePoints) {
            int hour = stoi(time.substr(0, 2));
            int minute = stoi(time.substr(3, 2));
            minutes.push_back(hour * 60 + minute);
        }
        sort(minutes.begin(), minutes.end());

        int minDiff = INT_MAX;
        for (int i = 0; i < minutes.size() - 1; ++i) {
            minDiff = min(minDiff, minutes[i + 1] - minutes[i]);
        }

        minDiff = min(minDiff, minutes[0] + 1440 - minutes.back());

        return minDiff;
    }
};