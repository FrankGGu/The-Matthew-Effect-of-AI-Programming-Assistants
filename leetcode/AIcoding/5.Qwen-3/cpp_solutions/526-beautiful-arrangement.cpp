#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countArrangement(int n) {
        vector<bool> visited(n + 1, false);
        int result = 0;
        backtrack(1, n, visited, result);
        return result;
    }

private:
    void backtrack(int pos, int n, vector<bool>& visited, int& result) {
        if (pos > n) {
            result++;
            return;
        }
        for (int i = 1; i <= n; ++i) {
            if (!visited[i] && (i % pos == 0 || pos % i == 0)) {
                visited[i] = true;
                backtrack(pos + 1, n, visited, result);
                visited[i] = false;
            }
        }
    }
};