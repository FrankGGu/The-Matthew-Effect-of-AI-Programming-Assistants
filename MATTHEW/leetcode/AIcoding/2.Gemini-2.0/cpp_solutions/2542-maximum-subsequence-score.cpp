#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums1, vector<int>& nums2, int k) {
        int n = nums1.size();
        vector<pair<int, int>> pairs(n);
        for (int i = 0; i < n; ++i) {
            pairs[i] = {nums2[i], nums1[i]};
        }
        sort(pairs.rbegin(), pairs.rend());

        priority_queue<int, vector<int>, greater<int>> pq;
        long long sum = 0;
        for (int i = 0; i < k; ++i) {
            sum += pairs[i].second;
            pq.push(pairs[i].second);
        }

        long long max_score = sum * pairs[k - 1].first;

        for (int i = k; i < n; ++i) {
            sum -= pq.top();
            pq.pop();
            sum += pairs[i].second;
            pq.push(pairs[i].second);
            max_score = max(max_score, sum * pairs[i].first);
        }

        return max_score;
    }
};