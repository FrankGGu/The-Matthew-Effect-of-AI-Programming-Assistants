#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numBusesToDestination(vector<vector<int>>& routes, int source, int target) {
        if (source == target) return 0;

        unordered_map<int, vector<int>> routeMap;
        for (int i = 0; i < routes.size(); ++i) {
            for (int stop : routes[i]) {
                routeMap[stop].push_back(i);
            }
        }

        unordered_set<int> visitedStops;
        queue<pair<int, int>> q;
        visitedStops.insert(source);
        for (int bus : routeMap[source]) {
            for (int stop : routes[bus]) {
                if (stop == target) return 1;
                q.push({bus, stop});
            }
        }

        while (!q.empty()) {
            auto [bus, stop] = q.front();
            q.pop();

            for (int nextBus : routeMap[stop]) {
                if (nextBus == bus) continue;
                for (int nextStop : routes[nextBus]) {
                    if (nextStop == target) return 2;
                    if (visitedStops.find(nextStop) == visitedStops.end()) {
                        visitedStops.insert(nextStop);
                        q.push({nextBus, nextStop});
                    }
                }
            }
        }

        return -1;
    }
};