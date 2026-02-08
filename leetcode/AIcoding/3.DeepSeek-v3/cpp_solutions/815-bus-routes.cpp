class Solution {
public:
    int numBusesToDestination(vector<vector<int>>& routes, int source, int target) {
        if (source == target) return 0;

        unordered_map<int, vector<int>> stopToBuses;
        for (int i = 0; i < routes.size(); ++i) {
            for (int stop : routes[i]) {
                stopToBuses[stop].push_back(i);
            }
        }

        queue<int> q;
        unordered_set<int> visitedStops;
        unordered_set<int> visitedBuses;
        q.push(source);
        visitedStops.insert(source);
        int buses = 0;

        while (!q.empty()) {
            int size = q.size();
            ++buses;
            for (int i = 0; i < size; ++i) {
                int currentStop = q.front();
                q.pop();
                for (int bus : stopToBuses[currentStop]) {
                    if (visitedBuses.count(bus)) continue;
                    visitedBuses.insert(bus);
                    for (int stop : routes[bus]) {
                        if (stop == target) return buses;
                        if (visitedStops.count(stop)) continue;
                        visitedStops.insert(stop);
                        q.push(stop);
                    }
                }
            }
        }

        return -1;
    }
};