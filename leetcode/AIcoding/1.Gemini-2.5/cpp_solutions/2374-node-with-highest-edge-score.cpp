#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int edgeScore(std::vector<int>& edges) {
        int n = edges.size();
        std::vector<long long> scores(n, 0);

        for (int i = 0; i < n; ++i) {
            scores[edges[i]] += i;
        }

        long long maxScore = -1;
        int maxNode = -1;

        for (int i = 0; i < n; ++i) {
            if (scores[i] > maxScore) {
                maxScore = scores[i];
                maxNode = i;
            }
        }

        return maxNode;
    }
};