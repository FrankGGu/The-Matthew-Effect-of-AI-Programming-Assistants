#include <vector>
#include <unordered_map>
#include <cstdlib>
#include <ctime>

using namespace std;

class RandomizedSet {
private:
    vector<int> nums;
    unordered_map<int, int> valToIndex;

public:
    RandomizedSet() {
        srand(time(nullptr));
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
        int lastVal = nums.back();
        nums[index] = lastVal;
        valToIndex[lastVal] = index;
        nums.pop_back();
        valToIndex.erase(val);
        return true;
    }

    int getRandom() {
        return nums[rand() % nums.size()];
    }
};