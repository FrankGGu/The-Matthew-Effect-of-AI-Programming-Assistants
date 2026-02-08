#include <vector>
#include <algorithm>
#include <queue>
#include <limits> // For std::numeric_limits

struct Worker {
    double ratio;
    int quality;

    Worker(int w, int q) : ratio(static_cast<double>(w) / q), quality(q) {}
};

bool compareWorkers(const Worker& a, const Worker& b) {
    return a.ratio < b.ratio;
}

class Solution {
public:
    double minCostToHireWorkers(std::vector<int>& quality, std::vector<int>& wage, int k) {
        int n = quality.size();
        std::vector<Worker> workers;
        for (int i = 0; i < n; ++i) {
            workers.emplace_back(wage[i], quality[i]);
        }

        std::sort(workers.begin(), workers.end(), compareWorkers);

        double min_cost = std::numeric_limits<double>::max();
        long long current_quality_sum = 0;
        std::priority_queue<int> pq; // Max-heap to store qualities

        for (int i = 0; i < n; ++i) {
            current_quality_sum += workers[i].quality;
            pq.push(workers[i].quality);

            if (pq.size() == k) {
                // We have k workers. The current worker workers[i] dictates the ratio.
                // The cost for this group is (dictating_ratio) * (sum_of_qualities_of_k_workers).
                double current_cost = workers[i].ratio * current_quality_sum;
                min_cost = std::min(min_cost, current_cost);

                // To prepare for the next iteration, we remove the worker with the largest quality
                // from our current group of k workers. This ensures that when we consider the
                // next worker (workers[i+1]) as the ratio-dictator, our priority queue
                // (which will then contain k-1 elements) holds the smallest qualities
                // from the workers considered so far (up to workers[i]).
                current_quality_sum -= pq.top();
                pq.pop();
            }
        }

        return min_cost;
    }
};