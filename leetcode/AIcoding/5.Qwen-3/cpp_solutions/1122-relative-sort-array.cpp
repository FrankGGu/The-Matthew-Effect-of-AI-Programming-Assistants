#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    std::vector<int> relativeSortArray(std::vector<int>& arr1, std::vector<int>& arr2) {
        std::map<int, int> indexMap;
        for (int i = 0; i < arr2.size(); ++i) {
            indexMap[arr2[i]] = i;
        }

        auto compare = [&](int a, int b) {
            if (indexMap.find(a) != indexMap.end() && indexMap.find(b) != indexMap.end()) {
                return indexMap[a] < indexMap[b];
            } else if (indexMap.find(a) != indexMap.end()) {
                return true;
            } else if (indexMap.find(b) != indexMap.end()) {
                return false;
            } else {
                return a < b;
            }
        };

        std::sort(arr1.begin(), arr1.end(), compare);
        return arr1;
    }
};