class Solution {
public:
    long long maxSpending(vector<vector<int>>& values) {
        priority_queue<int, vector<int>, greater<int>> pq;
        for (auto& row : values) {
            for (int num : row) {
                pq.push(num);
            }
        }
        long long res = 0;
        int day = 1;
        while (!pq.empty()) {
            res += (long long)pq.top() * day;
            pq.pop();
            day++;
        }
        return res;
    }
};