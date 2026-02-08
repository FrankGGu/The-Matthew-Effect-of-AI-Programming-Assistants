#include <vector>
#include <algorithm>
#include <queue>
using namespace std;

class Solution {
public:
    int maxPerformance(int n, vector<int>& speed, vector<int>& efficiency, int k) {
        vector<pair<int, int>> engineers;
        for (int i = 0; i < n; ++i) {
            engineers.emplace_back(efficiency[i], speed[i]);
        }
        sort(engineers.rbegin(), engineers.rend());

        priority_queue<int, vector<int>, greater<int>> minHeap;
        long sum = 0;
        long res = 0;
        for (auto& [e, s] : engineers) {
            if (minHeap.size() == k) {
                sum -= minHeap.top();
                minHeap.pop();
            }
            minHeap.push(s);
            sum += s;
            res = max(res, sum * e);
        }
        return res % (int)(1e9 + 7);
    }
};