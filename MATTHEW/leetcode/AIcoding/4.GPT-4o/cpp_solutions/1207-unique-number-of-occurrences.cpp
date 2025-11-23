#include <vector>
#include <unordered_map>
#include <unordered_set>

class Solution {
public:
    bool uniqueOccurrences(std::vector<int>& arr) {
        std::unordered_map<int, int> count;
        for (int num : arr) {
            count[num]++;
        }

        std::unordered_set<int> occurrences;
        for (const auto& pair : count) {
            occurrences.insert(pair.second);
        }

        return occurrences.size() == count.size();
    }
};