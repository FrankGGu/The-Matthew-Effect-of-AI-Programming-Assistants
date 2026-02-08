#include <iostream>
#include <vector>
#include <map>

class Solution {
public:
    std::vector<int> arrayRankTransform(std::vector<int>& arr) {
        std::map<int, int> rankMap;
        std::vector<int> sortedArr = arr;
        std::sort(sortedArr.begin(), sortedArr.end());

        int rank = 1;
        for (int num : sortedArr) {
            if (rankMap.find(num) == rankMap.end()) {
                rankMap[num] = rank++;
            }
        }

        std::vector<int> result;
        for (int num : arr) {
            result.push_back(rankMap[num]);
        }

        return result;
    }
};