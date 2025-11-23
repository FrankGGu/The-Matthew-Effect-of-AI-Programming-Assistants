#include <vector>
#include <queue>
#include <unordered_set>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int jump(int position, int a, int b, std::vector<int>& obstacle) {
        if (position == 0) {
            return 0;
        }

        std::unordered_set<long long> obstacle_set(obstacle.begin(), obstacle.end());
        if (obstacle_set.count(0)) {
            return -1;
        }

        std::queue<long long> q_fwd;
        std::unordered_map<long long, int> dist_fwd;
        q_fwd.push(0);
        dist_fwd[0] = 0;

        std::queue<long long> q_bwd;
        std::unordered_map<long long, int> dist_bwd;
        if (!obstacle_set.count(position)) {
            q_bwd.push(position);
            dist_bwd[position] = 0;
        }

        long long max_obs = 0;
        for (int obs : obstacle) {
            max_obs = std::max(max_obs, (long long)obs);
        }
        long long limit = std::max((long long)position, max_obs) + a + b;

        while (!q_fwd.empty() && !q_bwd.empty()) {
            if (q_fwd.size() <= q_bwd.size()) {
                int level_size = q_fwd.size();
                for (int i = 0; i < level_size; ++i) {
                    long long curr = q_fwd.front();
                    q_fwd.pop();
                    int d = dist_fwd[curr];

                    long long next_a = curr + a;
                    long long next_b = curr + b;

                    if (dist_bwd.count(next_a)) {
                        return d + 1 + dist_bwd[next_a];
                    }
                    if (dist_bwd.count(next_b)) {
                        return d + 1 + dist_bwd[next_b];
                    }

                    if (next_a <= limit && !obstacle_set.count(next_a) && !dist_fwd.count(next_a)) {
                        dist_fwd[next_a] = d + 1;
                        q_fwd.push(next_a);
                    }
                    if (next_b <= limit && !obstacle_set.count(next_b) && !dist_fwd.count(next_b)) {
                        dist_fwd[next_b] = d + 1;
                        q_fwd.push(next_b);
                    }
                }
            } else {
                int level_size = q_bwd.size();
                for (int i = 0; i < level_size; ++i) {
                    long long curr = q_bwd.front();
                    q_bwd.pop();
                    int d = dist_bwd[curr];

                    long long prev_a = curr - a;
                    long long prev_b = curr - b;

                    if (dist_fwd.count(prev_a)) {
                        return d + 1 + dist_fwd[prev_a];
                    }
                    if (dist_fwd.count(prev_b)) {
                        return d + 1 + dist_fwd[prev_b];
                    }

                    if (prev_a >= 0 && !obstacle_set.count(prev_a) && !dist_bwd.count(prev_a)) {
                        dist_bwd[prev_a] = d + 1;
                        q_bwd.push(prev_a);
                    }
                    if (prev_b >= 0 && !obstacle_set.count(prev_b) && !dist_bwd.count(prev_b)) {
                        dist_bwd[prev_b] = d + 1;
                        q_bwd.push(prev_b);
                    }
                }
            }
        }

        return -1;
    }
};