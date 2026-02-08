#include <vector>
#include <algorithm>
#include <list>

class Solution {
public:
    std::vector<std::vector<int>> reconstructQueue(std::vector<std::vector<int>>& people) {
        std::sort(people.begin(), people.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[0] != b[0]) {
                return a[0] > b[0];
            }
            return a[1] < b[1];
        });

        std::vector<std::vector<int>> res;
        res.reserve(people.size());
        for (const auto& person : people) {
            res.insert(res.begin() + person[1], person);
        }
        return res;
    }
};