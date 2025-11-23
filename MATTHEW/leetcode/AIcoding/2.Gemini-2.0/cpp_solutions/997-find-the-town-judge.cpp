#include <vector>

using namespace std;

class Solution {
public:
    int findJudge(int n, vector<vector<int>>& trust) {
        if (n == 1 && trust.empty()) return 1;
        vector<int> inDegree(n + 1, 0);
        vector<int> outDegree(n + 1, 0);

        for (auto& t : trust) {
            outDegree[t[0]]++;
            inDegree[t[1]]++;
        }

        for (int i = 1; i <= n; ++i) {
            if (inDegree[i] == n - 1 && outDegree[i] == 0) {
                return i;
            }
        }

        return -1;
    }
};