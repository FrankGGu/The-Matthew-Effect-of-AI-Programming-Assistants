#include <vector>
#include <unordered_map>
#include <unordered_set>

class Solution {
public:
    bool uniqueOccurrences(std::vector<int>& arr) {
        std::unordered_map<int, int> freq;
        for (int num : arr) {
            freq[num]++;
        }

        std::unordered_set<int> occurrences;
        for (const auto& pair : freq) {
            if (occurrences.count(pair.second)) {
                return false;
            }
            occurrences.insert(pair.second);
        }

        return true;
    }
};