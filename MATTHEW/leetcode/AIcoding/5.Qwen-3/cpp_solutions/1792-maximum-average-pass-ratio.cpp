#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    double maxAveragePassRatio(vector<int>& students, vector<int>& exams) {
        int n = students.size();
        priority_queue<pair<double, int>> pq;

        for (int i = 0; i < n; ++i) {
            double passRatio = static_cast<double>(students[i]) / exams[i];
            double delta = (students[i] + 1.0) / (exams[i] + 1.0) - passRatio;
            pq.push({delta, i});
        }

        for (int i = 0; i < n; ++i) {
            auto [delta, idx] = pq.top();
            pq.pop();
            students[idx]++;
        }

        double total = 0;
        for (int i = 0; i < n; ++i) {
            total += static_cast<double>(students[i]) / exams[i];
        }

        return total / n;
    }
};