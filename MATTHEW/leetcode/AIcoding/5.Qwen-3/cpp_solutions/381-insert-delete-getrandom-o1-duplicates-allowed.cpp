#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <cstdlib>

class Solution {
private:
    std::vector<int> nums;
    std::unordered_map<int, std::unordered_set<int>> indexMap;

public:
    Solution() {}

    bool insert(int val) {
        nums.push_back(val);
        indexMap[val].insert(nums.size() - 1);
        return true;
    }

    bool remove(int val) {
        if (indexMap.find(val) == indexMap.end() || indexMap[val].empty()) {
            return false;
        }

        int lastNum = nums.back();
        int idx = *indexMap[val].begin();

        nums[idx] = lastNum;
        indexMap[lastNum].erase(nums.size() - 1);
        indexMap[lastNum].insert(idx);

        indexMap[val].erase(idx);
        nums.pop_back();

        return true;
    }

    int getRandom() {
        return nums[rand() % nums.size()];
    }
};