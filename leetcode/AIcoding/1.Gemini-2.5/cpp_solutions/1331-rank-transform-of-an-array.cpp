#include <vector>
#include <algorithm>
#include <unordered_map>

class Solution {
public:
    std::vector<int> arrayRankTransform(std::vector<int>& arr) {
        if (arr.empty()) {
            return {};
        }

        std::vector<int> sortedArr = arr;
        std::sort(sortedArr.begin(), sortedArr.end());

        std::unordered_map<int, int> rankMap;
        int rank = 1;
        for (int num : sortedArr) {
            if (rankMap.find(num) == rankMap.end()) {
                rankMap[num] = rank++;
            }
        }

        std::vector<int> result(arr.size());
        for (size_t i = 0; i < arr.size(); ++i) {
            result[i] = rankMap[arr[i]];
        }

        return result;
    }
};