#include <vector>
#include <queue>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int smallestChair(vector<vector<int>>& times, int targetFriend) {
        int n = times.size();
        vector<pair<int, int>> arrivals;
        vector<pair<int, int>> departures;
        for (int i = 0; i < n; ++i) {
            arrivals.emplace_back(times[i][0], i);
            departures.emplace_back(times[i][1], i);
        }
        sort(arrivals.begin(), arrivals.end());
        sort(departures.begin(), departures.end());

        priority_queue<int, vector<int>, greater<int>> available;
        for (int i = 0; i < n; ++i) {
            available.push(i);
        }

        vector<int> seat(n, -1);
        int i = 0, j = 0;
        while (i < n) {
            if (arrivals[i].first < departures[j].first) {
                int chair = available.top();
                available.pop();
                seat[arrivals[i].second] = chair;
                if (arrivals[i].second == targetFriend) {
                    return chair;
                }
                ++i;
            } else {
                int chair = seat[departures[j].second];
                available.push(chair);
                ++j;
            }
        }
        return -1;
    }
};