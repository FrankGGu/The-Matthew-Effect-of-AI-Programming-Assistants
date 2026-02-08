class Solution {
public:
    vector<int> maxSubsequence(vector<int>& nums, int k) {
        priority_queue<pair<int, int>> pq;
        for (int i = 0; i < nums.size(); ++i) {
            pq.push({nums[i], i});
        }

        vector<pair<int, int>> temp;
        for (int i = 0; i < k; ++i) {
            temp.push_back(pq.top());
            pq.pop();
        }

        sort(temp.begin(), temp.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.second < b.second;
        });

        vector<int> res;
        for (auto& p : temp) {
            res.push_back(p.first);
        }

        return res;
    }
};