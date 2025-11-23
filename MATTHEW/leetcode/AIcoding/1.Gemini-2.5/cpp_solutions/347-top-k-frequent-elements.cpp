#include <vector>
#include <unordered_map>
#include <queue>
#include <utility> // For std::pair

class Solution {
public:
    std::vector<int> topKFrequent(std::vector<int>& nums, int k) {
        std::unordered_map<int, int> freq_map;
        for (int num : nums) {
            freq_map[num]++;
        }

        // Min-priority queue to store pairs of (frequency, element)
        // std::greater makes it a min-heap based on the first element of the pair (frequency)
        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> pq;

        for (auto const& [element, frequency] : freq_map) {
            pq.push({frequency, element});
            if (pq.size() > k) {
                pq.pop();
            }
        }

        std::vector<int> result;
        while (!pq.empty()) {
            result.push_back(pq.top().second);
            pq.pop();
        }

        return result;
    }
};