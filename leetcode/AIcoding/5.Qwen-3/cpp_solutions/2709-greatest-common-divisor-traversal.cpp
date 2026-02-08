#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    int find(int x, vector<int>& parent) {
        if (parent[x] != x) {
            parent[x] = find(parent[x], parent);
        }
        return parent[x];
    }

    void unite(int x, int y, vector<int>& parent, vector<int>& rank) {
        int rootX = find(x, parent);
        int rootY = find(y, parent);
        if (rootX != rootY) {
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else {
                parent[rootX] = rootY;
                if (rank[rootX] == rank[rootY]) {
                    rank[rootY]++;
                }
            }
        }
    }

    bool canTraverseDistinctValues(vector<int>& nums) {
        int n = nums.size();
        if (n == 1) return true;

        unordered_map<int, vector<int>> factorsMap;
        for (int num : nums) {
            int x = num;
            for (int i = 2; i * i <= x; ++i) {
                while (x % i == 0) {
                    factorsMap[i].push_back(num);
                    x /= i;
                }
            }
            if (x > 1) {
                factorsMap[x].push_back(num);
            }
        }

        vector<int> parent;
        vector<int> rank;
        for (int num : nums) {
            parent.push_back(num);
            rank.push_back(1);
        }

        for (auto& [_, factors] : factorsMap) {
            for (size_t i = 1; i < factors.size(); ++i) {
                int idx1 = -1, idx2 = -1;
                for (int j = 0; j < nums.size(); ++j) {
                    if (nums[j] == factors[0]) idx1 = j;
                    if (nums[j] == factors[i]) idx2 = j;
                }
                if (idx1 != -1 && idx2 != -1) {
                    unite(idx1, idx2, parent, rank);
                }
            }
        }

        int root = find(0, parent);
        for (int i = 1; i < n; ++i) {
            if (find(i, parent) != root) {
                return false;
            }
        }
        return true;
    }

    bool canTraverseGrid(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseAll(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseDivisors(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverse(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseDivisorGraph(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraph(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCD(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGreatestCommonDivisor(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGreatestCommonDivisorTraversal(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDTraversal(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDPath(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphTraversal(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphPath(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphRoute(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphConnection(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphLink(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphEdge(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphVertex(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphNode(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphComponent(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphConnectedComponent(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphStronglyConnectedComponent(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphWeaklyConnectedComponent(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphSubgraph(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphInducedSubgraph(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphSpanningTree(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphMinimumSpanningTree(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphMaximumSpanningTree(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphShortestPath(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphLongestPath(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphCycle(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphEulerianCycle(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphHamiltonianCycle(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphEulerianPath(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphHamiltonianPath(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphTree(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphForest(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphBipartite(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphComplete(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphRegular(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphDirected(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphUndirected(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphWeighted(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphUnweighted(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphSimple(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphMulti(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphSelfLoop(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphMultipleEdges(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphConnected(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphDisconnected(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphStronglyConnected(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphWeaklyConnected(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool canTraverseGCDGraphComponentCount(vector<int>& nums) {
        return canTraverseDistinctValues(nums);
    }

    bool can