#include <string>
#include <vector>
#include <unordered_set>
#include <functional>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minimumBeautifulSubstrings(string s) {
        int n = s.length();
        std::unordered_set<int> powers;
        int p = 1;
        while (true) {
            powers.insert(p);
            if (p > INT_MAX / 5) break;
            p *= 5;
        }

        std::vector<int> memo(n, -1);
        const int INF = n + 1;

        std::function<int(int)> solve = [&](int start_idx) {
            if (start_idx == n) {
                return 0;
            }
            if (memo[start_idx] != -1) {
                return memo[start_idx];
            }

            if (s[start_idx] == '0') {
                return memo[start_idx] = INF;
            }

            int min_partitions = INF;
            long long current_num = 0;

            for (int i = start_idx; i < n; ++i) {
                current_num = (current_num << 1) | (s[i] - '0');
                if (powers.count(current_num)) {
                    int next_partitions = solve(i + 1);
                    if (next_partitions < INF) {
                        min_partitions = std::min(min_partitions, 1 + next_partitions);
                    }
                }
            }

            return memo[start_idx] = min_partitions;
        };

        int result = solve(0);
        return result >= INF ? -1 : result;
    }
};