#include <vector>
#include <unordered_map>
#include <cstdlib>

using namespace std;

class RandomizedSet {
public:
    RandomizedSet() {

    }

    bool insert(int val) {
        if (valToIndex.count(val)) {
            return false;
        }
        nums.push_back(val);
        valToIndex[val] = nums.size() - 1;
        return true;
    }

    bool remove(int val) {
        if (!valToIndex.count(val)) {
            return false;
        }
        int index = valToIndex[val];
        int lastElement = nums.back();
        nums[index] = lastElement;
        valToIndex[lastElement] = index;
        nums.pop_back();
        valToIndex.erase(val);
        return true;
    }

    int getRandom() {
        return nums[rand() % nums.size()];
    }

private:
    vector<int> nums;
    unordered_map<int, int> valToIndex;
};