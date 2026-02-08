#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minRefuelStops(int target, int startFuel, vector<vector<int>>& stations) {
        int n = stations.size();
        priority_queue<int> pq;
        int i = 0;
        int stops = 0;
        int currentFuel = startFuel;

        while (currentFuel < target) {
            while (i < n && stations[i][0] <= currentFuel) {
                pq.push(stations[i][1]);
                i++;
            }

            if (pq.empty()) {
                return -1;
            }

            currentFuel += pq.top();
            pq.pop();
            stops++;
        }

        return stops;
    }
};