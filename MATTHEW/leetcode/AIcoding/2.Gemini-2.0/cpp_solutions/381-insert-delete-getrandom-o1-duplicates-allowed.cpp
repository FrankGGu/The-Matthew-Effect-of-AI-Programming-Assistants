#include <vector>
#include <unordered_map>
#include <cstdlib>

using namespace std;

class RandomizedCollection {
private:
    vector<int> nums;
    unordered_map<int, vector<int>> indexMap;

public:
    RandomizedCollection() {

    }

    bool insert(int val) {
        nums.push_back(val);
        indexMap[val].push_back(nums.size() - 1);
        return indexMap[val].size() == 1;
    }

    bool remove(int val) {
        if (indexMap.find(val) == indexMap.end() || indexMap[val].empty()) {
            return false;
        }

        int indexToRemove = indexMap[val].back();
        indexMap[val].pop_back();

        if (indexToRemove == nums.size() - 1) {
            nums.pop_back();
            return true;
        }

        int lastElement = nums.back();
        nums[indexToRemove] = lastElement;
        nums.pop_back();

        indexMap[lastElement].pop_back();

        for (int i = 0; i < indexMap[lastElement].size(); ++i) {
            if (indexMap[lastElement][i] == nums.size()) {
                indexMap[lastElement][i] = indexToRemove;
                break;
            }
        }

        indexMap[lastElement].push_back(indexToRemove);

        return true;
    }

    int getRandom() {
        return nums[rand() % nums.size()];
    }
};