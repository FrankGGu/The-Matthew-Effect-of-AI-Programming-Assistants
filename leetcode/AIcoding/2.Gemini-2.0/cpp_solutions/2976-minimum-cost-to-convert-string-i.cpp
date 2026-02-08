#include <vector>
#include <queue>
#include <limits>

using namespace std;

class Solution {
public:
    long long minimumCost(string source, string target, vector<char>& original, vector<char>& changed, vector<int>& cost) {
        vector<vector<long long>> dist(26, vector<long long>(26, numeric_limits<long long>::max()));
        for (int i = 0; i < 26; ++i) {
            dist[i][i] = 0;
        }

        for (int i = 0; i < original.size(); ++i) {
            dist[original[i] - 'a'][changed[i] - 'a'] = min((long long)cost[i], dist[original[i] - 'a'][changed[i] - 'a']);
        }

        for (int k = 0; k < 26; ++k) {
            for (int i = 0; i < 26; ++i) {
                for (int j = 0; j < 26; ++j) {
                    if (dist[i][k] != numeric_limits<long long>::max() && dist[k][j] != numeric_limits<long long>::max()) {
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        long long totalCost = 0;
        for (int i = 0; i < source.size(); ++i) {
            if (source[i] == target[i]) continue;
            if (dist[source[i] - 'a'][target[i] - 'a'] == numeric_limits<long long>::max()) return -1;
            totalCost += dist[source[i] - 'a'][target[i] - 'a'];
        }

        return totalCost;
    }
};