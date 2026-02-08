#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minHammingDistance(vector<int>& source, vector<int>& target, vector<vector<int>>& allowedSwaps) {
        int n = source.size();
        vector<int> parent(n);
        iota(parent.begin(), parent.end(), 0);

        function<int(int)> find = [&](int x) {
            if (parent[x] == x) {
                return x;
            }
            return parent[x] = find(parent[x]);
        };

        auto unite = [&](int x, int y) {
            x = find(x);
            y = find(y);
            if (x != y) {
                parent[x] = y;
            }
        };

        for (auto& swap : allowedSwaps) {
            unite(swap[0], swap[1]);
        }

        vector<vector<int>> groups(n);
        for (int i = 0; i < n; ++i) {
            groups[find(i)].push_back(i);
        }

        int hammingDistance = 0;
        for (int i = 0; i < n; ++i) {
            if (groups[i].empty()) continue;

            vector<int> sourceValues;
            vector<int> targetValues;

            for (int index : groups[i]) {
                sourceValues.push_back(source[index]);
                targetValues.push_back(target[index]);
            }

            sort(sourceValues.begin(), sourceValues.end());
            sort(targetValues.begin(), targetValues.end());

            int sourceIndex = 0;
            int targetIndex = 0;

            while (sourceIndex < sourceValues.size() && targetIndex < targetValues.size()) {
                if (sourceValues[sourceIndex] == targetValues[targetIndex]) {
                    sourceIndex++;
                    targetIndex++;
                } else if (sourceValues[sourceIndex] < targetValues[targetIndex]) {
                    sourceIndex++;
                    hammingDistance++;
                } else {
                    targetIndex++;
                    hammingDistance++;
                }
            }

            hammingDistance += (sourceValues.size() - sourceIndex);
            hammingDistance += (targetValues.size() - targetIndex);
            groups[i].clear();
        }

        return hammingDistance;
    }
};