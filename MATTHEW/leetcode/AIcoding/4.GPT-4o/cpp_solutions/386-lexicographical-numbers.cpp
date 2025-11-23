#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    vector<int> lexicalOrder(int n) {
        vector<int> result;
        for (int i = 1; i <= 9; i++) {
            dfs(i, n, result);
        }
        return result;
    }

    void dfs(int curr, int n, vector<int>& result) {
        if (curr > n) return;
        result.push_back(curr);
        for (int i = 0; i <= 9; i++) {
            dfs(curr * 10 + i, n, result);
        }
    }
};