#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int timeToCross(int n, int k, vector<vector<int>>& time) {
        priority_queue<pair<int, int>> available;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> waitingLeft, waitingRight;
        for (int i = 0; i < k; ++i) {
            available.push({time[i][0] + time[i][2], i});
        }

        int currentTime = 0;
        while (n > 0) {
            while (!waitingRight.empty() && waitingRight.top().first <= currentTime) {
                available.push({time[waitingRight.top().second][0] + time[waitingRight.top().second][2], waitingRight.top().second});
                waitingRight.pop();
            }

            if (available.empty()) {
                currentTime = max(currentTime, waitingRight.top().first);
                continue;
            }

            int workerIndex = available.top().second;
            available.pop();
            currentTime += time[workerIndex][0];
            n--;

            if (n == 0) {
                currentTime += time[workerIndex][2];
                break;
            }

            waitingRight.push({currentTime + time[workerIndex][1] + time[workerIndex][2], workerIndex});
        }

        while (!waitingRight.empty()) {
            currentTime = max(currentTime, waitingRight.top().first);
            waitingRight.pop();
        }

        return currentTime;
    }
};