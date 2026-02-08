#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

class Solution {
public:
    bool uniqueOccurrences(std::vector<int>& arr) {
        std::unordered_map<int, int> countMap;
        for (int num : arr) {
            countMap[num]++;
        }

        std::unordered_set<int> occurrenceSet;
        for (const auto& pair : countMap) {
            if (occurrenceSet.find(pair.second) != occurrenceSet.end()) {
                return false;
            }
            occurrenceSet.insert(pair.second);
        }

        return true;
    }
};