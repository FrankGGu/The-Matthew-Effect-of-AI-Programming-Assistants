#include <vector>
#include <unordered_map>

class Solution {
public:
    std::vector<std::vector<int>> groupThePeople(std::vector<int>& groupSizes) {
        std::vector<std::vector<int>> result;
        std::unordered_map<int, std::vector<int>> tempGroups;
        for (int i = 0; i < groupSizes.size(); ++i) {
            int size = groupSizes[i];
            tempGroups[size].push_back(i);
            if (tempGroups[size].size() == size) {
                result.push_back(tempGroups[size]);
                tempGroups.erase(size);
            }
        }
        return result;
    }
};