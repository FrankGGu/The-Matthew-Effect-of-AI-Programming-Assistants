class RandomizedCollection {
private:
    unordered_map<int, unordered_set<int>> valToIndices;
    vector<int> nums;
public:
    RandomizedCollection() {

    }

    bool insert(int val) {
        bool exists = valToIndices.find(val) != valToIndices.end();
        valToIndices[val].insert(nums.size());
        nums.push_back(val);
        return !exists;
    }

    bool remove(int val) {
        if (valToIndices.find(val) == valToIndices.end()) {
            return false;
        }
        int last = nums.back();
        if (val == last) {
            valToIndices[val].erase(nums.size() - 1);
            nums.pop_back();
        } else {
            int index = *valToIndices[val].begin();
            valToIndices[val].erase(index);
            nums[index] = last;
            valToIndices[last].erase(nums.size() - 1);
            valToIndices[last].insert(index);
            nums.pop_back();
        }
        if (valToIndices[val].empty()) {
            valToIndices.erase(val);
        }
        return true;
    }

    int getRandom() {
        return nums[rand() % nums.size()];
    }
};