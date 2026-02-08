#include <vector>
#include <queue>
#include <numeric>

struct ClassInfo {
    double gain;
    int p; // current passing students
    int t; // current total students
};

struct CompareClassInfo {
    bool operator()(const ClassInfo& a, const ClassInfo& b) {
        // For a max-heap, 'a' is considered "less than" 'b' if a.gain is smaller.
        // This means 'b' (with larger gain) should have higher priority (come before 'a').
        return a.gain < b.gain;
    }
};

class Solution {
public:
    double maxAverageRatio(std::vector<std::vector<int>>& classes, int extraStudents) {
        std::priority_queue<ClassInfo, std::vector<ClassInfo>, CompareClassInfo> max_pq;

        for (const auto& cls : classes) {
            int p = cls[0];
            int t = cls[1];
            // Calculate the gain if one student is added to this class
            // (p+1)/(t+1) - p/t
            double current_ratio = static_cast<double>(p) / t;
            double next_ratio = static_cast<double>(p + 1) / (t + 1);
            double gain = next_ratio - current_ratio;
            max_pq.push({gain, p, t});
        }

        for (int i = 0; i < extraStudents; ++i) {
            ClassInfo current_best = max_pq.top();
            max_pq.pop();

            int p_new = current_best.p + 1;
            int t_new = current_best.t + 1;

            // Calculate the new gain for the updated class
            double current_ratio_new = static_cast<double>(p_new) / t_new;
            double next_ratio_new = static_cast<double>(p_new + 1) / (t_new + 1);
            double new_gain = next_ratio_new - current_ratio_new;

            max_pq.push({new_gain, p_new, t_new});
        }

        double total_ratio_sum = 0.0;
        while (!max_pq.empty()) {
            ClassInfo cs = max_pq.top();
            max_pq.pop();
            total_ratio_sum += static_cast<double>(cs.p) / cs.t;
        }

        return total_ratio_sum / classes.size();
    }
};