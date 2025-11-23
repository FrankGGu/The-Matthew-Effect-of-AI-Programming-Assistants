class Solution {
public:
    int minRefuelStops(int target, int startFuel, vector<vector<int>>& stations) {
        priority_queue<int> maxHeap;
        int res = 0, prev = 0;
        stations.push_back({target, 0});
        for (auto& station : stations) {
            int pos = station[0], fuel = station[1];
            startFuel -= (pos - prev);
            while (startFuel < 0 && !maxHeap.empty()) {
                startFuel += maxHeap.top();
                maxHeap.pop();
                res++;
            }
            if (startFuel < 0) return -1;
            maxHeap.push(fuel);
            prev = pos;
        }
        return res;
    }
};