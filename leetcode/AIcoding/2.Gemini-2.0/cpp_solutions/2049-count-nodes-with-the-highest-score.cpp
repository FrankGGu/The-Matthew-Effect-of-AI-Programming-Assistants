#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countHighestScoreNodes(vector<int>& parents) {
        int n = parents.size();
        vector<vector<int>> children(n);
        for (int i = 1; i < n; ++i) {
            children[parents[i]].push_back(i);
        }

        long long maxScore = 0;
        int count = 0;

        function<int(int)> dfs = [&](int node) {
            int leftSize = 0;
            int rightSize = 0;

            if (children[node].size() > 0) {
                leftSize = dfs(children[node][0]);
            }
            if (children[node].size() > 1) {
                rightSize = dfs(children[node][1]);
            }

            long long score = 1;
            if (leftSize > 0) {
                score *= leftSize;
            }
            if (rightSize > 0) {
                score *= rightSize;
            }
            if (node != 0) {
                score *= (n - leftSize - rightSize - 1 == 0 ? 1 : n - leftSize - rightSize - 1);
            }

            if (score > maxScore) {
                maxScore = score;
                count = 1;
            } else if (score == maxScore) {
                count++;
            }

            return leftSize + rightSize + 1;
        };

        dfs(0);
        return count;
    }
};