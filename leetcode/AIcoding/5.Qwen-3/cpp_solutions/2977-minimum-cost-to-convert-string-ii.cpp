#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int minCost(string source, string target, vector<char> &original, vector<char> &changed, vector<int> &cost) {
        unordered_map<char, vector<pair<char, int>>> graph;
        for (int i = 0; i < original.size(); ++i) {
            graph[original[i]].push_back({changed[i], cost[i]});
        }

        for (char c = 'a'; c <= 'z'; ++c) {
            if (graph.find(c) == graph.end()) {
                graph[c] = {};
            }
        }

        vector<int> dist(26, INT_MAX);
        for (char c = 'a'; c <= 'z'; ++c) {
            priority_queue<pair<int, char>, vector<pair<int, char>>, greater<>> pq;
            dist[c - 'a'] = 0;
            pq.push({0, c});

            while (!pq.empty()) {
                auto [d, u] = pq.top();
                pq.pop();
                if (d > dist[u - 'a']) continue;
                for (auto [v, w] : graph[u]) {
                    if (dist[v - 'a'] > d + w) {
                        dist[v - 'a'] = d + w;
                        pq.push({dist[v - 'a'], v});
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < source.length(); ++i) {
            if (source[i] == target[i]) continue;
            int idx = target[i] - 'a';
            if (dist[idx] == INT_MAX) return -1;
            result += dist[idx];
        }

        return result;
    }
};