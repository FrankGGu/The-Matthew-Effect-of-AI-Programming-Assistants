#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int transportationHub(vector<vector<int>>& path) {
        unordered_set<int> nodes;
        unordered_map<int, int> in_degree;
        unordered_map<int, int> out_degree;

        for (const auto& p : path) {
            int from = p[0];
            int to = p[1];
            nodes.insert(from);
            nodes.insert(to);
            out_degree[from]++;
            in_degree[to]++;
        }

        int n = nodes.size();
        for (const auto& node : nodes) {
            if (in_degree[node] == n - 1 && out_degree[node] == 0) {
                return node;
            }
        }

        return -1;
    }
};