#include <vector>
#include <algorithm>
#include <queue>
#include <map>

using namespace std;

class Solution {
public:
    int smallestChair(vector<vector<int>>& times, int targetFriend) {
        int targetArrivalTime = times[targetFriend][0];
        int n = times.size();

        vector<pair<int, int>> arrivalTimes(n);
        for (int i = 0; i < n; ++i) {
            arrivalTimes[i] = {times[i][0], i};
        }
        sort(arrivalTimes.begin(), arrivalTimes.end());

        priority_queue<int, vector<int>, greater<int>> availableChairs;
        for (int i = 0; i <= n; ++i) {
            availableChairs.push(i);
        }

        map<int, int> friendToChair;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> occupiedChairs;

        for (int i = 0; i < n; ++i) {
            int arrivalTime = arrivalTimes[i].first;
            int friendId = arrivalTimes[i].second;

            while (!occupiedChairs.empty() && occupiedChairs.top().first <= arrivalTime) {
                availableChairs.push(occupiedChairs.top().second);
                occupiedChairs.pop();
            }

            int chair = availableChairs.top();
            availableChairs.pop();
            friendToChair[friendId] = chair;
            occupiedChairs.push({times[friendId][1], chair});

            if (friendId == targetFriend) {
                return chair;
            }
        }

        return -1;
    }
};