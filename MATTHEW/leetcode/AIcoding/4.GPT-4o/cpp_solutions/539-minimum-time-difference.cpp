#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>
#include <cmath>

using namespace std;

int findMinDifference(vector<string>& timePoints) {
    vector<int> minutes;
    for (const string& time : timePoints) {
        int hour = stoi(time.substr(0, 2));
        int minute = stoi(time.substr(3, 2));
        minutes.push_back(hour * 60 + minute);
    }
    sort(minutes.begin(), minutes.end());
    int minDiff = INT_MAX;
    for (int i = 1; i < minutes.size(); ++i) {
        minDiff = min(minDiff, minutes[i] - minutes[i - 1]);
    }
    minDiff = min(minDiff, (minutes[0] + 1440 - minutes.back()));
    return minDiff;
}