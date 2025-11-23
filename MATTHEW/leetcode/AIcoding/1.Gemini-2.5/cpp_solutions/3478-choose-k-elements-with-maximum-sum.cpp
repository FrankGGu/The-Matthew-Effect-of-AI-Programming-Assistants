#include <vector>
#include <queue>
#include <cmath>

class Solution {
public:
    long long pickGifts(std::vector<int>& gifts, int k) {
        std::priority_queue<int> pq(gifts.begin(), gifts.end());
        long long total_score = 0;

        for (int i = 0; i < k; ++i) {
            int max_gift = pq.top();
            pq.pop();
            total_score += max_gift;
            pq.push(static_cast<int>(sqrt(max_gift)));
        }

        return total_score;
    }
};