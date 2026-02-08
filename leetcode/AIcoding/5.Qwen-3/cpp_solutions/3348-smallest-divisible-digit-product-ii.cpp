#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int smallestDivisibleByN(int n) {
        if (n % 2 == 0 || n % 5 == 0) {
            return -1;
        }

        vector<int> visited(1000, 0);
        queue<pair<int, int>> q;
        q.push({1, 1});
        visited[1] = 1;

        while (!q.empty()) {
            auto [current, digits] = q.front();
            q.pop();

            if (current % n == 0) {
                return digits;
            }

            for (int d = 1; d <= 9; ++d) {
                int next = (current * d) % n;
                if (!visited[next]) {
                    visited[next] = 1;
                    q.push({next, digits + 1});
                }
            }
        }

        return -1;
    }
};