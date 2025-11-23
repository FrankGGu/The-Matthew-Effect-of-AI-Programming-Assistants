#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    long long minSumSquareDiff(vector<int>& nums1, vector<int>& nums2, int k1, int k2) {
        int n = nums1.size();
        priority_queue<int> pq;
        for (int i = 0; i < n; ++i) {
            pq.push(abs(nums1[i] - nums2[i]));
        }

        int k = k1 + k2;
        while (k > 0) {
            int top = pq.top();
            pq.pop();
            if (top == 0) break;
            pq.push(top - 1);
            k--;
        }

        long long ans = 0;
        while (!pq.empty()) {
            long long top = pq.top();
            pq.pop();
            ans += top * top;
        }

        return ans;
    }
};