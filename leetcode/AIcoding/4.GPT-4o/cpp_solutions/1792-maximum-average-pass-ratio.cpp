class Solution {
public:
    double maxAverageRatio(vector<vector<int>>& classes, int extraStudents) {
        auto cmp = [](pair<double, pair<int, int>>& a, pair<double, pair<int, int>>& b) {
            return a.first < b.first;
        };

        priority_queue<pair<double, pair<int, int>>, vector<pair<double, pair<int, int>>>, decltype(cmp)> maxHeap(cmp);

        for (auto& cls : classes) {
            int pass = cls[0], total = cls[1];
            maxHeap.push({(double)(pass + 1) / (total + 1) - (double)pass / total, {pass, total}});
        }

        while (extraStudents-- > 0) {
            auto top = maxHeap.top();
            maxHeap.pop();
            int pass = top.second.first, total = top.second.second;
            pass++;
            total++;
            maxHeap.push({(double)(pass + 1) / (total + 1) - (double)pass / total, {pass, total}});
        }

        double totalAverage = 0.0;
        while (!maxHeap.empty()) {
            auto top = maxHeap.top();
            maxHeap.pop();
            totalAverage += (double)top.second.first / top.second.second;
        }

        return totalAverage / classes.size();
    }
};