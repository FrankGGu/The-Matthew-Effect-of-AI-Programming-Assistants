#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int kthSmallestSum(vector<int>& nums1, vector<int>& nums2, int k) {
        auto comp = [&](int a, int b) { return a > b; };
        priority_queue<int, vector<int>, decltype(comp)> pq(comp);
        for (int i = 0; i < nums1.size(); ++i) {
            pq.push(nums1[i] + nums2[0]);
        }
        for (int j = 0; j < k - 1; ++j) {
            int sum = pq.top();
            pq.pop();
            int idx = 0;
            while (idx < nums2.size() && sum != nums1[0] + nums2[idx]) {
                ++idx;
            }
            if (idx + 1 < nums2.size()) {
                pq.push(sum - nums2[idx] + nums2[idx + 1]);
            }
        }
        return pq.top();
    }
};