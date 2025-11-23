#include <vector>
#include <unordered_map>
#include <queue>
#include <utility>

class Solution {
public:
    std::vector<long long> mostFrequentIDs(std::vector<int>& nums, std::vector<int>& freq) {
        std::unordered_map<long long, long long> id_counts;
        std::priority_queue<std::pair<long long, long long>> pq;
        std::vector<long long> ans;

        for (size_t i = 0; i < nums.size(); ++i) {
            long long id = nums[i];
            long long change = freq[i];

            id_counts[id] += change;

            pq.push({id_counts[id], id});

            while (!pq.empty() && pq.top().first != id_counts[pq.top().second]) {
                pq.pop();
            }

            if (pq.empty()) {
                ans.push_back(0);
            } else {
                ans.push_back(pq.top().first);
            }
        }

        return ans;
    }
};