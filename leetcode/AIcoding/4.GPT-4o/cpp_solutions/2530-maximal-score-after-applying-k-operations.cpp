class Solution {
public:
    long long maxScore(vector<int>& nums1, vector<int>& nums2, int k) {
        int n = nums1.size();
        vector<pair<int, int>> pairs(n);
        for (int i = 0; i < n; ++i) {
            pairs[i] = {nums2[i], nums1[i]};
        }
        sort(pairs.rbegin(), pairs.rend());

        long long maxScore = 0, currentSum = 0;
        priority_queue<int, vector<int>, greater<int>> minHeap;

        for (int i = 0; i < k; ++i) {
            currentSum += pairs[i].second;
            minHeap.push(pairs[i].second);
        }
        maxScore = currentSum * pairs[k - 1].first;

        for (int i = k; i < n; ++i) {
            currentSum += pairs[i].second;
            currentSum -= minHeap.top();
            minHeap.pop();
            minHeap.push(pairs[i].second);
            maxScore = max(maxScore, currentSum * pairs[i].first);
        }

        return maxScore;
    }
};