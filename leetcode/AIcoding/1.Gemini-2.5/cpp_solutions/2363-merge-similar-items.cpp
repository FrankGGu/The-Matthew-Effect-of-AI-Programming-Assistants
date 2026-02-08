#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> mergeSimilarItems(std::vector<std::vector<int>>& items1, std::vector<std::vector<int>>& items2) {
        std::map<int, int> merged_items_map;

        for (const auto& item : items1) {
            merged_items_map[item[0]] += item[1];
        }

        for (const auto& item : items2) {
            merged_items_map[item[0]] += item[1];
        }

        std::vector<std::vector<int>> result;
        for (const auto& pair : merged_items_map) {
            result.push_back({pair.first, pair.second});
        }

        return result;
    }
};