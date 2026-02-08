#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums1, vector<int>& nums2, int k) {
        int n = nums1.size();
        vector<int> indices(n);
        iota(indices.begin(), indices.end(), 0);

        sort(indices.begin(), indices.end(), [&](int i, int j) {
            return nums2[i] > nums2[j];
        });

        long long maxSum1 = 0;
        long long minNum2 = 0;
        long long ans = 0;

        vector<int> topK;
        for (int i = 0; i < k; ++i) {
            topK.push_back(nums1[indices[i]]);
            maxSum1 += nums1[indices[i]];
        }
        minNum2 = nums2[indices[k - 1]];
        ans = maxSum1 * minNum2;

        for (int i = k; i < n; ++i) {
            int smallestIndex = 0;
            for (int j = 1; j < k; ++j) {
                if (topK[j] < topK[smallestIndex]) {
                    smallestIndex = j;
                }
            }

            if (nums1[indices[i]] > topK[smallestIndex]) {
                maxSum1 -= topK[smallestIndex];
                maxSum1 += nums1[indices[i]];
                topK[smallestIndex] = nums1[indices[i]];
                minNum2 = nums2[indices[i]];
                ans = max(ans, maxSum1 * nums2[indices[i]]);
            }
        }

        return ans;
    }
};