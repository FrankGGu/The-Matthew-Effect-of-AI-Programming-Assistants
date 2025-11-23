#include <vector>
#include <unordered_map>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maximalNetworkRank(int n, vector<vector<int>>& roads) {
        unordered_map<int, int> cityDegree;
        unordered_set<string> roadSet;
        for (const auto& road : roads) {
            cityDegree[road[0]]++;
            cityDegree[road[1]]++;
            roadSet.insert(to_string(road[0]) + "-" + to_string(road[1]));
            roadSet.insert(to_string(road[1]) + "-" + to_string(road[0]));
        }

        int maxRank = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int rank = cityDegree[i] + cityDegree[j];
                if (roadSet.count(to_string(i) + "-" + to_string(j))) {
                    rank--;
                }
                maxRank = max(maxRank, rank);
            }
        }

        return maxRank;
    }
};