#include <vector>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    int edgeScore(vector<int>& edges) {
        unordered_map<int, long long> scores;
        int n = edges.size();
        for (int i = 0; i < n; ++i) {
            scores[edges[i]] += i;
        }

        long long maxScore = -1;
        int result = INT_MAX;
        for (auto& [node, score] : scores) {
            if (score > maxScore || (score == maxScore && node < result)) {
                maxScore = score;
                result = node;
            }
        }

        return result;
    }
};