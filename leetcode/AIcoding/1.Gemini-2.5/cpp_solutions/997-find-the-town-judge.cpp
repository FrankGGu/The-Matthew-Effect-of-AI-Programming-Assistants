#include <vector>
#include <numeric>

class Solution {
public:
    int findJudge(int n, std::vector<std::vector<int>>& trust) {
        if (n == 1) {
            return 1;
        }

        std::vector<int> inDegree(n + 1, 0);
        std::vector<int> outDegree(n + 1, 0);

        for (const auto& t : trust) {
            int a = t[0];
            int b = t[1];
            outDegree[a]++;
            inDegree[b]++;
        }

        for (int i = 1; i <= n; ++i) {
            if (outDegree[i] == 0 && inDegree[i] == n - 1) {
                return i;
            }
        }

        return -1;
    }
};