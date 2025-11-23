#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>

using namespace std;

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

        queue<pair<int, int>> q;
        q.push({source, 0});

        unordered_set<int> visitedStops;
        unordered_set<int> visitedBuses;

        visitedStops.insert(source);

        while (!q.empty()) {
            int stop = q.front().first;
            int numBuses = q.front().second;
            q.pop();

            if (stop == target) return numBuses;

            for (int bus : stopToBuses[stop]) {
                if (visitedBuses.count(bus)) continue;
                visitedBuses.insert(bus);

                for (int nextStop : routes[bus]) {
                    if (visitedStops.count(nextStop)) continue;
                    visitedStops.insert(nextStop);
                    q.push({nextStop, numBuses + 1});
                }
            }
        }

        return -1;
    }
};