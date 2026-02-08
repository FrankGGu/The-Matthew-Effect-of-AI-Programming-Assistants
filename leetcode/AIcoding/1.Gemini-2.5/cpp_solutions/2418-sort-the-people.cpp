#include <vector>
#include <string>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<std::string> sortPeople(std::vector<std::string>& names, std::vector<int>& heights) {
        std::vector<std::pair<int, std::string>> people;
        for (size_t i = 0; i < names.size(); ++i) {
            people.push_back({heights[i], names[i]});
        }

        std::sort(people.begin(), people.end(), [](const std::pair<int, std::string>& a, const std::pair<int, std::string>& b) {
            return a.first > b.first;
        });

        std::vector<std::string> sortedNames;
        for (const auto& p : people) {
            sortedNames.push_back(p.second);
        }

        return sortedNames;
    }
};