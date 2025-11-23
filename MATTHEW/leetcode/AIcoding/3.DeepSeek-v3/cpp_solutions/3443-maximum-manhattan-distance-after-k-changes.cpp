#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int maxManhattanDistance(vector<int>& nums1, vector<int>& nums2, int k) {
        priority_queue<int> pq;
        int n = nums1.size();
        for (int i = 0; i < n; ++i) {
            int diff = abs(nums1[i] - nums2[i]);
            pq.push(diff);
        }

        while (k > 0 && !pq.empty()) {
            int top = pq.top();
            pq.pop();
            if (top > 0) {
                pq.push(top - 1);
            } else {
                pq.push(top + 1);
            }
            k--;
        }

        int max1 = INT_MIN, min1 = INT_MAX;
        int max2 = INT_MIN, min2 = INT_MAX;

        vector<int> new_nums1, new_nums2;
        while (!pq.empty()) {
            int diff = pq.top();
            pq.pop();
            new_nums1.push_back(nums1[0] + diff);
            new_nums2.push_back(nums2[0] - diff);
        }

        for (int num : new_nums1) {
            max1 = max(max1, num);
            min1 = min(min1, num);
        }

        for (int num : new_nums2) {
            max2 = max(max2, num);
            min2 = min(min2, num);
        }

        return (max1 - min1) + (max2 - min2);
    }
};