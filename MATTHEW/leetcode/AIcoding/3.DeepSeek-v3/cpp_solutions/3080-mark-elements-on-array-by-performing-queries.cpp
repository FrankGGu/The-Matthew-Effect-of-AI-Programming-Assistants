class Solution {
public:
    vector<long long> unmarkedSumArray(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        vector<bool> marked(n, false);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;

        long long sum = 0;
        for (int i = 0; i < n; ++i) {
            sum += nums[i];
            pq.push({nums[i], i});
        }

        vector<long long> result;
        for (const auto& query : queries) {
            int index = query[0];
            int k = query[1];

            if (!marked[index]) {
                marked[index] = true;
                sum -= nums[index];
            }

            while (k > 0 && !pq.empty()) {
                auto [val, idx] = pq.top();
                pq.pop();
                if (!marked[idx]) {
                    marked[idx] = true;
                    sum -= val;
                    --k;
                }
            }

            result.push_back(sum);
        }

        return result;
    }
};