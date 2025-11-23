#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> intervalIntersection(std::vector<std::vector<int>>& firstList, std::vector<std::vector<int>>& secondList) {
        std::vector<std::vector<int>> result;
        int i = 0;
        int j = 0;

        while (i < firstList.size() && j < secondList.size()) {
            int low = std::max(firstList[i][0], secondList[j][0]);
            int high = std::min(firstList[i][1], secondList[j][1]);

            if (low <= high) {
                result.push_back({low, high});
            }

            if (firstList[i][1] < secondList[j][1]) {
                i++;
            } else {
                j++;
            }
        }

        return result;
    }
};