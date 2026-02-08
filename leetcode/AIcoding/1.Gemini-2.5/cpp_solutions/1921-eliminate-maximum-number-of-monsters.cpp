#include <vector>
#include <algorithm> // For std::sort

class Solution {
public:
    int eliminateMaximum(std::vector<int>& dist, std::vector<int>& speed) {
        int n = dist.size();
        std::vector<double> arrival_times;
        arrival_times.reserve(n);

        for (int i = 0; i < n; ++i) {
            arrival_times.push_back(static_cast<double>(dist[i]) / speed[i]);
        }

        std::sort(arrival_times.begin(), arrival_times.end());

        int eliminated_count = 0;
        for (int i = 0; i < n; ++i) {
            if (arrival_times[i] > i) {
                eliminated_count++;
            } else {
                break;
            }
        }

        return eliminated_count;
    }
};