#include <vector>
#include <queue>
#include <cmath>
#include <numeric>

class Solution {
public:
    long long pickGifts(std::vector<int>& piles, int k) {
        std::priority_queue<long long> pq;
        for (int pile : piles) {
            pq.push(pile);
        }

        for (int i = 0; i < k; ++i) {
            long long top_pile = pq.top();
            pq.pop();
            long long new_pile = static_cast<long long>(std::sqrt(top_pile));
            pq.push(new_pile);
        }

        long long total_gifts = 0;
        while (!pq.empty()) {
            total_gifts += pq.top();
            pq.pop();
        }

        return total_gifts;
    }
};