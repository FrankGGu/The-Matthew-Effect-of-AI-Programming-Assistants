class Solution {
public:
    int highestScoreNode(vector<int>& edges) {
        int n = edges.size();
        vector<long long> score(n, 0);

        for (int i = 0; i < n; ++i) {
            if (edges[i] != -1) {
                score[edges[i]] += i;
            }
        }

        int maxScoreIndex = 0;
        for (int i = 1; i < n; ++i) {
            if (score[i] > score[maxScoreIndex]) {
                maxScoreIndex = i;
            }
        }

        return maxScoreIndex;
    }
};