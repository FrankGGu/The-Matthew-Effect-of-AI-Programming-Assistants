#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    double maxProbability(int n, vector<vector<int>>& edges, vector<double>& succProb, int start, int end) {
        vector<vector<pair<int, double>>> graph(n);
        for (int i = 0; i < edges.size(); i++) {
            graph[edges[i][0]].emplace_back(edges[i][1], succProb[i]);
            graph[edges[i][1]].emplace_back(edges[i][0], succProb[i]);
        }

        vector<double> maxProb(n, 0.0);
        maxProb[start] = 1.0;
        priority_queue<pair<double, int>> pq;
        pq.push({1.0, start});

        while (!pq.empty()) {
            double prob = pq.top().first;
            int node = pq.top().second;
            pq.pop();

            if (node == end) return prob;

            for (const auto& neighbor : graph[node]) {
                int nextNode = neighbor.first;
                double nextProb = prob * neighbor.second;
                if (nextProb > maxProb[nextNode]) {
                    maxProb[nextNode] = nextProb;
                    pq.push({nextProb, nextNode});
                }
            }
        }

        return 0.0;
    }
};