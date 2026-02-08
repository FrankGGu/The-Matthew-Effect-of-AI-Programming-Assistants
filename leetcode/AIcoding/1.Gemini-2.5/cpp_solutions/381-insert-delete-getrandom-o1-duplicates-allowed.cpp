class RandomizedCollection {
public:
    vector<int> nums;
    unordered_map<int, vector<int>> indices;

    RandomizedCollection() {
    }

    bool insert(int val) {
        nums.push_back(val);
        indices[val].push_back(nums.size() - 1);
        return indices[val].size() == 1;
    }

    bool remove(int val) {
        if (indices.find(val) == indices.end() || indices[val].empty()) return false;

        int indexToRemove = indices[val].back();
        indices[val].pop_back();

        if (indexToRemove == nums.size() - 1) {
            nums.pop_back();
            return true;
        }

        int lastElement = nums.back();
        nums[indexToRemove] = lastElement;
        nums.pop_back();

        indices[lastElement].pop_back();
        indices[lastElement].push_back(indexToRemove);

        for(int i = 0; i < indices[lastElement].size(); ++i) {
            if(indices[lastElement][i] == nums.size()) {
                indices[lastElement][i] = indexToRemove;
                break;
            }
        }

        return true;
    }

    int getRandom() {
        return nums[rand() % nums.size()];
    }
};