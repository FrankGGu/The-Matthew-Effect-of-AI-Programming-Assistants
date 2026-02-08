#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numBusesToDestination(vector<vector<int>>& routes, int source, int target) {
        if (source == target) return 0;

        unordered_map<int, vector<int>> stopToRoutes;
        for (int i = 0; i < routes.size(); ++i) {
            for (int stop : routes[i]) {
                stopToRoutes[stop].push_back(i);
            }
        }

        vector<bool> visitedBus(routes.size(), false);
        vector<bool> visitedStop(source, false);
        queue<int> q;
        for (int route : stopToRoutes[source]) {
            visitedBus[route] = true;
            for (int stop : routes[route]) {
                if (stop == target) return 1;
                q.push(stop);
            }
        }

        int steps = 1;
        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int currentStop = q.front();
                q.pop();
                for (int route : stopToRoutes[currentStop]) {
                    if (visitedBus[route]) continue;
                    visitedBus[route] = true;
                    for (int nextStop : routes[route]) {
                        if (nextStop == target) return steps + 1;
                        if (!visitedStop[nextStop]) {
                            visitedStop[nextStop] = true;
                            q.push(nextStop);
                        }
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};