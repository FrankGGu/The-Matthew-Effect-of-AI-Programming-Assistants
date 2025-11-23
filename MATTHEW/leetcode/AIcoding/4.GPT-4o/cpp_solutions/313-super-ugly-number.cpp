#include <vector>
#include <queue>
#include <unordered_set>

class Solution {
public:
    int nthSuperUglyNumber(int n, std::vector<int>& primes) {
        std::vector<int> ugly(n);
        ugly[0] = 1;
        int size = primes.size();
        std::vector<int> indices(size, 0);
        std::vector<int> next(size);
        auto cmp = [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            return a.first > b.first;
        };
        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, decltype(cmp)> pq(cmp);

        for (int i = 0; i < size; ++i) {
            next[i] = primes[i];
            pq.push({next[i], i});
        }

        for (int i = 1; i < n; ++i) {
            ugly[i] = pq.top().first;
            int idx = pq.top().second;
            pq.pop();
            while (!pq.empty() && pq.top().first == ugly[i]) {
                pq.pop();
            }
            indices[idx]++;
            next[idx] = primes[idx] * ugly[indices[idx]];
            pq.push({next[idx], idx});
        }

        return ugly[n - 1];
    }
};