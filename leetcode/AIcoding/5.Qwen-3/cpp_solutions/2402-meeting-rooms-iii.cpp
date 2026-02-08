#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mostBookedRoom(vector<vector<int>>& meetings, int n) {
        sort(meetings.begin(), meetings.end());
        vector<int> roomCount(n, 0);
        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<>> endTimes;

        for (int i = 0; i < n; ++i) {
            endTimes.push({0, i});
        }

        for (const auto& meeting : meetings) {
            int start = meeting[0], end = meeting[1];
            while (endTimes.top().first < start) {
                auto [time, room] = endTimes.top();
                endTimes.pop();
                endTimes.push({time, room});
            }

            auto [time, room] = endTimes.top();
            endTimes.pop();
            roomCount[room]++;
            endTimes.push({end, room});
        }

        return max_element(roomCount.begin(), roomCount.end()) - roomCount.begin();
    }
};