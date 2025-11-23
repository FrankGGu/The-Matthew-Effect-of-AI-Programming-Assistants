#include <unordered_map>
#include <vector>
#include <cstdlib>

class RandomizedSet {
public:
    RandomizedSet() {}

    bool insert(int val) {
        if (mp.count(val)) return false;
        nums.push_back(val);
        mp[val] = nums.size() - 1;
        return true;
    }

    bool remove(int val) {
        if (!mp.count(val)) return false;
        int last = nums.back();
        mp[last] = mp[val];
        nums[mp[val]] = last;
        nums.pop_back();
        mp.erase(val);
        return true;
    }

    int getRandom() {
        return nums[rand() % nums.size()];
    }

private:
    std::vector<int> nums;
    std::unordered_map<int, int> mp;
};