#include <iostream>
#include <vector>
#include <queue>
#include <cmath>

using namespace std;

class Solution {
public:
    double maxProbability(vector<vector<int>>& edges, int n, vector<double>& succProb, vector<int>& startAndEnd) {
        vector<vector<pair<int, double>>> graph(n);
        for (int i = 0; i < edges.size(); ++i) {
            int u = edges[i][0];
            int v = edges[i][1];
            double prob = succProb[i];
            graph[u].push_back({v, prob});
            graph[v].push_back({u, prob});
        }

        vector<double> prob(n, 0.0);
        prob[startAndEnd[0]] = 1.0;

        priority_queue<pair<double, int>> pq;
        pq.push({1.0, startAndEnd[0]});

        while (!pq.empty()) {
            auto [currentProb, u] = pq.top();
            pq.pop();

            if (u == startAndEnd[1]) {
                return currentProb;
            }

            if (currentProb < prob[u]) {
                continue;
            }

            for (auto& [v, p] : graph[u]) {
                double newProb = currentProb * p;
                if (newProb > prob[v]) {
                    prob[v] = newProb;
                    pq.push({newProb, v});
                }
            }
        }

        return 0.0;
    }
};