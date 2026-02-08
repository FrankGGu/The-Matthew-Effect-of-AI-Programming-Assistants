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

        // Min-heap to store (frequency, number) pairs
        // std::greater sorts in ascending order, making it a min-heap
        std::priority_queue<std::pair<int, int>, 
                            std::vector<std::pair<int, int>>, 
                            std::greater<std::pair<int, int>>> min_heap;

        for (auto const& [num, freq] : freq_map) {
            min_heap.push({freq, num});
            if (min_heap.size() > k) {
                min_heap.pop();
            }
        }

        std::vector<int> result;
        while (!min_heap.empty()) {
            result.push_back(min_heap.top().second);
            min_heap.pop();
        }

        return result;
    }
};