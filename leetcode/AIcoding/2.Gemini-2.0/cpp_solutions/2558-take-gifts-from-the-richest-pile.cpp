#include <vector>
#include <queue>
#include <cmath>

using namespace std;

class Solution {
public:
    long long pickGifts(vector<int>& gifts, int k) {
        priority_queue<int> pq;
        for (int gift : gifts) {
            pq.push(gift);
        }

        for (int i = 0; i < k; ++i) {
            int top = pq.top();
            pq.pop();
            pq.push(static_cast<int>(sqrt(top)));
        }

        long long sum = 0;
        while (!pq.empty()) {
            sum += pq.top();
            pq.pop();
        }

        return sum;
    }
};