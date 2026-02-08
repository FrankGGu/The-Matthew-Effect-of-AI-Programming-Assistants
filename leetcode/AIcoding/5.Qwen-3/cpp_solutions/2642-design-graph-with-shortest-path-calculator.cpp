#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    Solution() {}

    void addEdge(vector<int>& edge) {
        int u = edge[0];
        int v = edge[1];
        int weight = edge[2];
        graph[u].push_back({v, weight});
        graph[v].push_back({u, weight});
    }

    int shortestPath(int nodeA, int nodeB) {
        vector<int> dist(1001, INT_MAX);
        dist[nodeA] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.push({0, nodeA});

        while (!pq.empty()) {
            int currentDist = pq.top().first;
            int current = pq.top().second;
            pq.pop();

            if (current == nodeB) {
                return currentDist;
            }

            if (currentDist > dist[current]) {
                continue;
            }

            for (auto& neighbor : graph[current]) {
                int nextNode = neighbor.first;
                int nextDist = currentDist + neighbor.second;
                if (nextDist < dist[nextNode]) {
                    dist[nextNode] = nextDist;
                    pq.push({nextDist, nextNode});
                }
            }
        }

        return -1;
    }

private:
    unordered_map<int, vector<pair<int, int>>> graph;
};