#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    double maxAverageRatio(vector<vector<int>>& classes, int extraStudents) {
        priority_queue<pair<double, int>> pq;
        int n = classes.size();

        for (int i = 0; i < n; ++i) {
            double pass = classes[i][0];
            double total = classes[i][1];
            double diff = (pass + 1) / (total + 1) - pass / total;
            pq.push({diff, i});
        }

        for (int i = 0; i < extraStudents; ++i) {
            auto top = pq.top();
            pq.pop();
            int index = top.second;
            classes[index][0]++;
            classes[index][1]++;
            double pass = classes[index][0];
            double total = classes[index][1];
            double diff = (pass + 1) / (total + 1) - pass / total;
            pq.push({diff, index});
        }

        double sum = 0.0;
        for (auto& c : classes) {
            sum += (double)c[0] / c[1];
        }

        return sum / n;
    }
};