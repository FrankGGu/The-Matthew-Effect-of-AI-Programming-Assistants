#include <vector>

using namespace std;

class Solution {
public:
    int edgeScore(vector<int>& edges) {
        int n = edges.size();
        vector<long long> score(n, 0);
        for (int i = 0; i < n; ++i) {
            score[edges[i]] += i;
        }

        int maxNode = 0;
        for (int i = 1; i < n; ++i) {
            if (score[i] > score[maxNode]) {
                maxNode = i;
            }
        }

        return maxNode;
    }
};