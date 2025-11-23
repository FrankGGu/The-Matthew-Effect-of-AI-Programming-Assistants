#include <queue>
#include <unordered_set>
#include <climits>

class Solution {
public:
    int minimumOperationsToMakeEqual(int x, int y) {
        if (x == y) return 0;
        std::queue<std::pair<int, int>> q;
        std::unordered_set<int> visited;
        q.push({x, 0});
        visited.insert(x);

        while (!q.empty()) {
            auto [current, steps] = q.front();
            q.pop();

            if (current == y) {
                return steps;
            }

            int next;
            // Option 1: Increment by 1
            next = current + 1;
            if (next <= y * 2 && visited.find(next) == visited.end()) {
                visited.insert(next);
                q.push({next, steps + 1});
            }

            // Option 2: Decrement by 1
            next = current - 1;
            if (next >= 0 && visited.find(next) == visited.end()) {
                visited.insert(next);
                q.push({next, steps + 1});
            }

            // Option 3: Divide by 5 if divisible
            if (current % 5 == 0) {
                next = current / 5;
                if (next >= 0 && visited.find(next) == visited.end()) {
                    visited.insert(next);
                    q.push({next, steps + 1});
                }
            }

            // Option 4: Divide by 11 if divisible
            if (current % 11 == 0) {
                next = current / 11;
                if (next >= 0 && visited.find(next) == visited.end()) {
                    visited.insert(next);
                    q.push({next, steps + 1});
                }
            }
        }

        return -1;
    }
};