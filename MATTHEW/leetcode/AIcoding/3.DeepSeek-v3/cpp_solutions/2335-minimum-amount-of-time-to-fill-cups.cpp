#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int fillCups(vector<int>& amount) {
        priority_queue<int> pq;
        for (int num : amount) {
            if (num > 0) {
                pq.push(num);
            }
        }

        int time = 0;
        while (!pq.empty()) {
            int first = pq.top();
            pq.pop();
            if (pq.empty()) {
                time += first;
                break;
            }
            int second = pq.top();
            pq.pop();
            time += 1;
            first -= 1;
            second -= 1;
            if (first > 0) {
                pq.push(first);
            }
            if (second > 0) {
                pq.push(second);
            }
        }
        return time;
    }
};