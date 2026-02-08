#include <queue>
#include <vector>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums, int start, int goal) {
        queue<pair<int, int>> q;
        q.push({start, 0});
        vector<bool> visited(1001, false);
        if (start >= 0 && start <= 1000) {
            visited[start] = true;
        }

        while (!q.empty()) {
            int curr = q.front().first;
            int steps = q.front().second;
            q.pop();

            if (curr == goal) {
                return steps;
            }

            for (int num : nums) {
                int next1 = curr + num;
                int next2 = curr - num;
                int next3 = curr ^ num;

                if (next1 == goal || next2 == goal || next3 == goal) {
                    return steps + 1;
                }

                if (next1 >= 0 && next1 <= 1000 && !visited[next1]) {
                    q.push({next1, steps + 1});
                    visited[next1] = true;
                }
                if (next2 >= 0 && next2 <= 1000 && !visited[next2]) {
                    q.push({next2, steps + 1});
                    visited[next2] = true;
                }
                if (next3 >= 0 && next3 <= 1000 && !visited[next3]) {
                    q.push({next3, steps + 1});
                    visited[next3] = true;
                }

                 if (next1 >= 0 && next1 <= 1000) {

                 } else if (next1 == goal){
                     return steps+1;
                 }

                 if (next2 >= 0 && next2 <= 1000) {

                 } else if (next2 == goal){
                     return steps+1;
                 }

                 if (next3 >= 0 && next3 <= 1000) {

                 } else if (next3 == goal){
                     return steps+1;
                 }
            }
        }

        return -1;
    }
};