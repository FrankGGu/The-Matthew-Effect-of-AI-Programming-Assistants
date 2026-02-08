#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minTimeToCollectAllApples(int n, vector<vector<int>>& edges, vector<bool>& hasApple) {
        unordered_map<int, vector<int>> tree;
        for (const auto& edge : edges) {
            tree[edge[0]].push_back(edge[1]);
            tree[edge[1]].push_back(edge[0]);
        }

        function<int(int, int)> dfs = [&](int node, int parent) -> int {
            int time = 0;
            for (int child : tree[node]) {
                if (child != parent) {
                    int childTime = dfs(child, node);
                    if (childTime > 0 || hasApple[child]) {
                        time += childTime + 2;
                    }
                }
            }
            return time;
        };

        return dfs(0, -1);
    }
};