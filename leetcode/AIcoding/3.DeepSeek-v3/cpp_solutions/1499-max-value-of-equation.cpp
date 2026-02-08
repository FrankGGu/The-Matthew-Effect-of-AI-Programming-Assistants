class Solution {
public:
    int findMaxValueOfEquation(vector<vector<int>>& points, int k) {
        deque<int> dq;
        int res = INT_MIN;
        for (int j = 0; j < points.size(); ++j) {
            while (!dq.empty() && points[j][0] - points[dq.front()][0] > k) {
                dq.pop_front();
            }
            if (!dq.empty()) {
                int i = dq.front();
                res = max(res, points[i][1] + points[j][1] + points[j][0] - points[i][0]);
            }
            while (!dq.empty() && points[j][1] - points[j][0] >= points[dq.back()][1] - points[dq.back()][0]) {
                dq.pop_back();
            }
            dq.push_back(j);
        }
        return res;
    }
};