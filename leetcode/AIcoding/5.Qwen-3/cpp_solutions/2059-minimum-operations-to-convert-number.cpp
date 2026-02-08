#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minimumOperationsToConvertNumber(int target, int startNum, int goalNum) {
        if (startNum == goalNum) return 0;

        vector<int> visited(1001, 0);
        queue<pair<int, int>> q;
        q.push({startNum, 0});
        visited[startNum] = 1;

        while (!q.empty()) {
            auto [num, ops] = q.front();
            q.pop();

            if (num == goalNum) return ops;

            if (num + 1 <= 1000 && !visited[num + 1]) {
                visited[num + 1] = 1;
                q.push({num + 1, ops + 1});
            }

            if (num - 1 >= 0 && !visited[num - 1]) {
                visited[num - 1] = 1;
                q.push({num - 1, ops + 1});
            }

            if (num * 2 <= 1000 && !visited[num * 2]) {
                visited[num * 2] = 1;
                q.push({num * 2, ops + 1});
            }

            if (num / 2 >= 0 && !visited[num / 2]) {
                visited[num / 2] = 1;
                q.push({num / 2, ops + 1});
            }
        }

        return -1;
    }
};