#include <vector>

class Solution {
public:
    int countArrangement(int n) {
        std::vector<bool> visited(n + 1, false);
        int count = 0;
        backtrack(n, 1, visited, count);
        return count;
    }

private:
    void backtrack(int n, int pos, std::vector<bool>& visited, int& count) {
        if (pos > n) {
            count++;
            return;
        }

        for (int i = 1; i <= n; ++i) {
            if (!visited[i] && (i % pos == 0 || pos % i == 0)) {
                visited[i] = true;
                backtrack(n, pos + 1, visited, count);
                visited[i] = false;
            }
        }
    }
};