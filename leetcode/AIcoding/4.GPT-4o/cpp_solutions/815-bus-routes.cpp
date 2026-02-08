#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    int numBusesToDestination(vector<vector<int>>& routes, int S, int T) {
        if (S == T) return 0;

        unordered_map<int, vector<int>> busStopToRoutes;
        for (int i = 0; i < routes.size(); ++i) {
            for (int stop : routes[i]) {
                busStopToRoutes[stop].push_back(i);
            }
        }

        queue<int> q;
        unordered_set<int> visitedBuses;
        unordered_set<int> visitedStops;
        q.push(S);
        visitedStops.insert(S);
        int buses = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int stop = q.front();
                q.pop();

                for (int bus : busStopToRoutes[stop]) {
                    if (visitedBuses.count(bus)) continue;
                    visitedBuses.insert(bus);

                    for (int nextStop : routes[bus]) {
                        if (nextStop == T) return buses + 1;
                        if (!visitedStops.count(nextStop)) {
                            visitedStops.insert(nextStop);
                            q.push(nextStop);
                        }
                    }
                }
            }
            buses++;
        }

        return -1;
    }
};