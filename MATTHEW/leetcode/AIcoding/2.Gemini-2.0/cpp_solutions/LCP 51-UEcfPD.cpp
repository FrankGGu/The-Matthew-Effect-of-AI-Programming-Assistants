#include <vector>

using namespace std;

class Solution {
public:
    int deliciousness(vector<int>& happiness, vector<vector<int>>& ingredients, int target) {
        int n = happiness.size();
        int m = ingredients[0].size();
        int count = 0;
        vector<int> used(n, 0);

        function<void(int, int)> dfs = [&](int index, int sum) {
            if (index == n) {
                if (sum == target) {
                    count = (count + 1) % 1000000007;
                }
                return;
            }

            dfs(index + 1, sum);

            dfs(index + 1, sum + happiness[index]);

        };

        dfs(0, 0);

        return count;
    }
};