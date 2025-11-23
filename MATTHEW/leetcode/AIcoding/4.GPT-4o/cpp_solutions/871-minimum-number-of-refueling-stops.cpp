class Solution {
public:
    int minRefuelStops(int target, int startFuel, vector<vector<int>>& stations) {
        priority_queue<int> pq;
        int n = stations.size();
        int res = 0, currPos = 0, fuel = startFuel;

        for (int i = 0; i <= n; ++i) {
            int nextPos = (i == n) ? target : stations[i][0];
            fuel -= nextPos - currPos;
            while (fuel < 0 && !pq.empty()) {
                fuel += pq.top();
                pq.pop();
                ++res;
            }
            if (fuel < 0) return -1;
            currPos = nextPos;
            if (i < n) pq.push(stations[i][1]);
        }
        return res;
    }
};