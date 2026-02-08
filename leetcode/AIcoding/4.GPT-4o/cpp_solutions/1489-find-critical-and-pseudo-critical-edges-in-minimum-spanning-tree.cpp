class Solution {
public:
    vector<vector<int>> findCriticalAndPseudoCriticalEdges(int n, vector<vector<int>>& edges) {
        vector<vector<int>> result;
        vector<tuple<int, int, int>> edgeList;
        for (int i = 0; i < edges.size(); ++i) {
            edgeList.emplace_back(edges[i][2], edges[i][0], edges[i][1]);
        }
        sort(edgeList.begin(), edgeList.end());

        auto find = [&](int x) {
            if (parent[x] != x) parent[x] = find(parent[x]);
            return parent[x];
        };

        auto unionSets = [&](int x, int y) {
            int rootX = find(x), rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
                return true;
            }
            return false;
        };

        auto kruskal = [&](int skipEdge = -1, int takeEdge = -1) {
            iota(parent.begin(), parent.end(), 0);
            int totalWeight = 0, edgesUsed = 0;

            if (takeEdge != -1) {
                totalWeight += get<0>(edgeList[takeEdge]);
                unionSets(get<1>(edgeList[takeEdge]), get<2>(edgeList[takeEdge]));
                edgesUsed++;
            }

            for (int i = 0; i < edgeList.size(); ++i) {
                if (i == skipEdge) continue;
                if (unionSets(get<1>(edgeList[i]), get<2>(edgeList[i]))) {
                    totalWeight += get<0>(edgeList[i]);
                    edgesUsed++;
                }
            }
            return edgesUsed == n - 1 ? totalWeight : INT_MAX;
        };

        parent.resize(n);
        int mstw = kruskal();

        vector<int> criticalEdges, pseudoCriticalEdges;

        for (int i = 0; i < edgeList.size(); ++i) {
            if (kruskal(i) > mstw) {
                criticalEdges.push_back(get<3>(edgeList[i]));
            } else if (kruskal(-1, i) == mstw) {
                pseudoCriticalEdges.push_back(get<3>(edgeList[i]));
            }
        }

        result.push_back(criticalEdges);
        result.push_back(pseudoCriticalEdges);
        return result;
    }

private:
    vector<int> parent;
};