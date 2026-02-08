#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums, int a, int b) {
        int n = nums.size();
        long long target = 0;
        for (int num : nums) {
            target += num;
        }

        if (target == 0) return 0;

        vector<bool> visited(n * 31, false);
        vector<pair<int, int>> q;
        q.push_back({0, 0});
        visited[0] = true;
        int head = 0;
        int steps = 0;

        while (head < q.size()) {
            int sz = q.size() - head;
            for (int i = 0; i < sz; ++i) {
                int curr_idx = q[head].first;
                int curr_ops = q[head].second;
                head++;

                if (nums[curr_idx] == 1) {
                    int next_idx = (curr_idx + 1) % n;
                    int next_ops = curr_ops + a;

                    if (next_idx == 0 && next_ops >= 31) continue;

                    if (!visited[next_idx + next_ops * n]) {
                        visited[next_idx + next_ops * n] = true;
                        q.push_back({next_idx, next_ops});
                    }
                } else {
                    int next_idx = (curr_idx + 1) % n;
                    if (!visited[next_idx + curr_ops * n]) {
                        visited[next_idx + curr_ops * n] = true;
                        q.push_back({next_idx, curr_ops});
                    }
                }

                int prev_idx = (curr_idx - 1 + n) % n;
                int next_ops = curr_ops + b;

                if (next_ops >= 31) continue;

                if (!visited[prev_idx + next_ops * n]) {
                    visited[prev_idx + next_ops * n] = true;
                    q.push_back({prev_idx, next_ops});
                }
            }

            steps++;
            for (int i = 0; i < q.size(); ++i) {
                if (q[i].first == 0 && q[i].second < 31) {
                    return steps;
                }
            }
        }

        return -1;
    }
};