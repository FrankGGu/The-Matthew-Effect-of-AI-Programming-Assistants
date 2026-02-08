#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumFuelCost(vector<int>& roads, int seats) {
        vector<vector<int>> graph(roads.size() + 1);
        for (auto& road : roads) {
            graph[road].push_back(road + 1);
            graph[road + 1].push_back(road);
        }

        long long fuel = 0;
        function<int(int, int)> dfs = [&](int node, int parent) -> int {
            int people = 1;
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    people += dfs(neighbor, node);
                }
            }
            if (node != 0) {
                fuel += (people + seats - 1) / seats;
            }
            return people;
        };

        dfs(0, -1);
        return fuel;
    }
};