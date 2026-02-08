#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums1, vector<int>& nums2, int k) {
        int n = nums1.size();
        vector<pair<int, int>> pairs(n);

        for (int i = 0; i < n; ++i) {
            pairs[i] = {nums1[i], nums2[i]};
        }

        sort(pairs.begin(), pairs.end(), [&](const pair<int, int>& a, const pair<int, int>& b) {
            return a.second > b.second;
        });

        priority_queue<int, vector<int>, greater<int>> minHeap;
        long long sum = 0;
        long long maxScore = 0;

        for (int i = 0; i < n; ++i) {
            sum += pairs[i].first;
            minHeap.push(pairs[i].first);

            if (minHeap.size() > k) {
                sum -= minHeap.top();
                minHeap.pop();
            }

            if (minHeap.size() == k) {
                maxScore = max(maxScore, sum * pairs[i].second);
            }
        }

        return maxScore;
    }
};