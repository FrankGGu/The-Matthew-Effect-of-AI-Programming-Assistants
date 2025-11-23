class Solution {
public:
    int maximumScore(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int maxScore = -1;
        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1];
            int score = nums[u] + nums[v];

            priority_queue<int> pq;
            for (int neighbor : graph[u]) {
                if (neighbor != v) {
                    pq.push(nums[neighbor]);
                }
            }
            for (int neighbor : graph[v]) {
                if (neighbor != u) {
                    pq.push(nums[neighbor]);
                }
            }

            if (pq.size() > 0) {
                score += pq.top();
            }
            if (pq.size() > 1) {
                pq.pop();
                score += pq.top();
            }

            maxScore = max(maxScore, score);
        }
        return maxScore;
    }
};