class Solution {
public:
    double mincostToHireWorkers(vector<int>& quality, vector<int>& wage, int k) {
        vector<pair<double, int>> workers;
        int n = quality.size();
        for (int i = 0; i < n; ++i) {
            workers.emplace_back((double)wage[i] / quality[i], quality[i]);
        }
        sort(workers.begin(), workers.end());

        priority_queue<int> maxHeap;
        double res = DBL_MAX;
        int sumQuality = 0;

        for (auto& worker : workers) {
            double ratio = worker.first;
            sumQuality += worker.second;
            maxHeap.push(worker.second);

            if (maxHeap.size() > k) {
                sumQuality -= maxHeap.top();
                maxHeap.pop();
            }

            if (maxHeap.size() == k) {
                res = min(res, sumQuality * ratio);
            }
        }

        return res;
    }
};