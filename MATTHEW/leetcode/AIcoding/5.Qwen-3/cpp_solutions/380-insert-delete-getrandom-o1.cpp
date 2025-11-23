#include <iostream>
#include <vector>
#include <unordered_map>
#include <cstdlib>

class Solution {
private:
    std::vector<int> nums;
    std::unordered_map<int, int> indexMap;
    std::random_device rd;
    std::mt19937 gen;

public:
    Solution() : gen(rd()) {}

    bool insert(int val) {
        if (indexMap.find(val) != indexMap.end()) {
            return false;
        }
        nums.push_back(val);
        indexMap[val] = nums.size() - 1;
        return true;
    }

    bool remove(int val) {
        if (indexMap.find(val) == indexMap.end()) {
            return false;
        }
        int last = nums.back();
        int idx = indexMap[val];
        nums[idx] = last;
        indexMap[last] = idx;
        nums.pop_back();
        indexMap.erase(val);
        return true;
    }

    int getRandom() {
        std::uniform_int_distribution<> dis(0, nums.size() - 1);
        return nums[dis(gen)];
    }
};