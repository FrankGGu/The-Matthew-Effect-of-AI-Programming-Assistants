#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    int earliestFullBloom(std::vector<int>& plantTime, std::vector<int>& growTime) {
        int n = plantTime.size();
        std::vector<std::pair<int, int>> flowers(n);
        for (int i = 0; i < n; ++i) {
            flowers[i] = {growTime[i], plantTime[i]};
        }

        std::sort(flowers.begin(), flowers.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            return a.first > b.first;
        });

        long long current_plant_time = 0;
        long long max_bloom_time = 0;

        for (int i = 0; i < n; ++i) {
            current_plant_time += flowers[i].second;
            long long bloom_time_for_current_flower = current_plant_time + flowers[i].first;
            max_bloom_time = std::max(max_bloom_time, bloom_time_for_current_flower);
        }

        return static_cast<int>(max_bloom_time);
    }
};