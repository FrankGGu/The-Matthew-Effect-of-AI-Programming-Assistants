#include <vector>
#include <queue>
using namespace std;

class Solution {
public:
    int pickGifts(vector<int>& gifts, int k) {
        priority_queue<int> pq(gifts.begin(), gifts.end());
        while (k--) {
            int largest = pq.top();
            pq.pop();
            pq.push(sqrt(largest));
        }
        int total = 0;
        while (!pq.empty()) {
            total += pq.top();
            pq.pop();
        }
        return total;
    }
};