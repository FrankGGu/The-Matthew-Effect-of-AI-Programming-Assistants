#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> fullBloomFlowers(std::vector<std::vector<int>>& flowers, std::vector<int>& persons) {
        std::vector<int> start_times;
        std::vector<int> end_times;

        for (const auto& flower : flowers) {
            start_times.push_back(flower[0]);
            end_times.push_back(flower[1] + 1);
        }

        std::sort(start_times.begin(), start_times.end());
        std::sort(end_times.begin(), end_times.end());

        std::vector<int> results(persons.size());

        for (int i = 0; i < persons.size(); ++i) {
            int p_time = persons[i];

            auto it_started = std::upper_bound(start_times.begin(), start_times.end(), p_time);
            int started_count = std::distance(start_times.begin(), it_started);

            auto it_ended = std::upper_bound(end_times.begin(), end_times.end(), p_time);
            int ended_count = std::distance(end_times.begin(), it_ended);

            results[i] = started_count - ended_count;
        }

        return results;
    }
};