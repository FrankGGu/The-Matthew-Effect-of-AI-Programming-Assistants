#include <vector>
#include <algorithm>
#include <unordered_map>

class Solution {
public:
    std::vector<int> arrayRankTransform(std::vector<int>& arr) {
        std::vector<int> sortedArr = arr;
        std::sort(sortedArr.begin(), sortedArr.end());

        std::unordered_map<int, int> rank;
        int currentRank = 1;

        for (int num : sortedArr) {
            if (rank.find(num) == rank.end()) {
                rank[num] = currentRank++;
            }
        }

        for (int& num : arr) {
            num = rank[num];
        }

        return arr;
    }
};