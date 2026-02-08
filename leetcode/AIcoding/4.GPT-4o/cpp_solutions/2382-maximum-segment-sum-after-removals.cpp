class Solution {
public:
    long long maximumSegmentSum(vector<int>& nums, vector<int>& removeQueries) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        vector<int> parent(n, -1);
        vector<long long> segmentSum(n, 0);
        long long maxSum = 0;

        auto find = [&](int x) {
            if (parent[x] < 0) return x;
            return parent[x] = find(parent[x]);
        };

        for (int i = 0; i < n; ++i) {
            int index = removeQueries[i];
            parent[index] = -1;
            segmentSum[index] = nums[index];
            maxSum = max(maxSum, segmentSum[index]);

            if (index > 0 && parent[index - 1] != -1) {
                int root = find(index - 1);
                segmentSum[root] += segmentSum[index];
                segmentSum[index] = 0;
                parent[index] = root;
                maxSum = max(maxSum, segmentSum[root]);
            }
            if (index < n - 1 && parent[index + 1] != -1) {
                int root = find(index + 1);
                segmentSum[root] += segmentSum[index];
                segmentSum[index] = 0;
                parent[index] = root;
                maxSum = max(maxSum, segmentSum[root]);
            }
        }

        return maxSum;
    }
};