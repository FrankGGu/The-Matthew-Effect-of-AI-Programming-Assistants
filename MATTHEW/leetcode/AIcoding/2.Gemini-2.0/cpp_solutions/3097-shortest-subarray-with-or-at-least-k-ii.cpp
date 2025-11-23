#include <vector>
#include <deque>

using namespace std;

int shortestSubarray(vector<int>& nums, int k) {
    int n = nums.size();
    vector<long long> pre(n + 1, 0);
    for (int i = 0; i < n; i++) {
        pre[i + 1] = pre[i] | nums[i];
    }

    int ans = n + 1;
    deque<int> q;
    for (int i = 0; i <= n; i++) {
        while (!q.empty() && pre[q.back()] <= pre[i]) {
            q.pop_back();
        }
        while (!q.empty() && (pre[i] | pre[q.front()]) >= k) {
            ans = min(ans, i - q.front());
            q.pop_front();
        }
        q.push_back(i);
    }

    return ans > n ? -1 : ans;
}