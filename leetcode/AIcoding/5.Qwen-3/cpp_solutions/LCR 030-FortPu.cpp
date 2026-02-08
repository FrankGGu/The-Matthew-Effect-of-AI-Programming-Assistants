#include <iostream>
#include <vector>
#include <unordered_map>
#include <cstdlib>
#include <ctime>

using namespace std;

class Solution {
private:
    vector<int> nums;
    unordered_map<int, int> indexMap;
    int size;

public:
    Solution() {
        size = 0;
        srand(time(0));
    }

    bool insert(int val) {
        if (indexMap.find(val) != indexMap.end()) {
            return false;
        }
        nums.push_back(val);
        indexMap[val] = size++;
        return true;
    }

    bool remove(int val) {
        if (indexMap.find(val) == indexMap.end()) {
            return false;
        }
        int lastNum = nums.back();
        int idx = indexMap[val];
        nums[idx] = lastNum;
        indexMap[lastNum] = idx;
        nums.pop_back();
        indexMap.erase(val);
        size--;
        return true;
    }

    int getRandom() {
        int randomIndex = rand() % size;
        return nums[randomIndex];
    }
};