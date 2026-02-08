#include <vector>
#include <unordered_map>
#include <cstdlib>
using namespace std;

class RandomizedSet {
private:
    vector<int> nums;
    unordered_map<int, int> valToIndex;

public:
    RandomizedSet() {
    }

    bool insert(int val) {
        if (valToIndex.find(val) != valToIndex.end()) {
            return false;
        }
        nums.push_back(val);
        valToIndex[val] = nums.size() - 1;
        return true;
    }

    bool remove(int val) {
        if (valToIndex.find(val) == valToIndex.end()) {
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
        int randomIndex = rand() % nums.size();
        return nums[randomIndex];
    }
};