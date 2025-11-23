#include <vector>
#include <queue>

using namespace std;

int minOperations(vector<int>& nums, int k) {
    priority_queue<long long, vector<long long>, greater<long long>> pq;
    for (int num : nums) {
        pq.push(num);
    }

    int operations = 0;
    while (pq.size() > 1 && pq.top() < k) {
        long long first = pq.top();
        pq.pop();
        if(pq.top() >= k) {
            pq.push(first);
            break;
        }
        long long second = pq.top();
        pq.pop();
        pq.push(min(k, first * 1LL + 2 * second * 1LL));
        operations++;
    }

    return (pq.empty() || pq.top() >= k) ? operations : -1;
}