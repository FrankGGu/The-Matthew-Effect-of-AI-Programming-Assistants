#include <vector>
#include <unordered_map>
#include <random>
#include <chrono>

class RandomizedSet {
private:
    std::vector<int> nums;
    std::unordered_map<int, int> val_to_index;
    std::mt19937 rng;

public:
    RandomizedSet() : rng(std::chrono::high_resolution_clock::now().time_since_epoch().count()) {

    }

    bool insert(int val) {
        if (val_to_index.count(val)) {
            return false;
        }

        nums.push_back(val);
        val_to_index[val] = nums.size() - 1;
        return true;
    }

    bool remove(int val) {
        if (!val_to_index.count(val)) {
            return false;
        }

        int index_to_remove = val_to_index[val];
        int last_element = nums.back();

        nums[index_to_remove] = last_element;
        val_to_index[last_element] = index_to_remove;

        nums.pop_back();
        val_to_index.erase(val);

        return true;
    }

    int getRandom() {
        std::uniform_int_distribution<int> dist(0, nums.size() - 1);
        int random_index = dist(rng);
        return nums[random_index];
    }
};