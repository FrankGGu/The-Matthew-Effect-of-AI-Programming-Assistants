#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int mostVisitedNode(int n, vector<int>& edges) {
        vector<int> score(n, 0);
        vector<int> next(n, -1);

        for (int i = 0; i < n; ++i) {
            if (edges[i] != -1) {
                next[i] = edges[i];
            }
        }

        int maxScore = 0;
        int resultNode = 0;

        for (int i = 0; i < n; ++i) {
            int current = i;
            int currentScore = 0;

            while (current != -1) {
                currentScore++;
                current = next[current];
            }

            if (currentScore > maxScore || (currentScore == maxScore && i < resultNode)) {
                maxScore = currentScore;
                resultNode = i;
            }
        }

        return resultNode;
    }
};