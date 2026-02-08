class Solution {
public:
    double maxAverageRatio(vector<vector<int>>& classes, int extraStudents) {
        auto profit = [](double pass, double total) {
            return (pass + 1) / (total + 1) - pass / total;
        };

        priority_queue<pair<double, int>> pq;
        for (int i = 0; i < classes.size(); ++i) {
            double p = profit(classes[i][0], classes[i][1]);
            pq.push({p, i});
        }

        while (extraStudents--) {
            auto [current_profit, i] = pq.top();
            pq.pop();
            classes[i][0] += 1;
            classes[i][1] += 1;
            double new_profit = profit(classes[i][0], classes[i][1]);
            pq.push({new_profit, i});
        }

        double total = 0;
        for (auto& c : classes) {
            total += (double)c[0] / c[1];
        }
        return total / classes.size();
    }
};