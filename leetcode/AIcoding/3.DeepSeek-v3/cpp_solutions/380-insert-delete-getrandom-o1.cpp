class RandomizedSet {
private:
    unordered_map<int, int> valToIndex;
    vector<int> vals;
public:
    RandomizedSet() {

    }

    bool insert(int val) {
        if (valToIndex.count(val)) {
            return false;
        }
        valToIndex[val] = vals.size();
        vals.push_back(val);
        return true;
    }

    bool remove(int val) {
        if (!valToIndex.count(val)) {
            return false;
        }
        int index = valToIndex[val];
        int lastVal = vals.back();
        valToIndex[lastVal] = index;
        vals[index] = lastVal;
        vals.pop_back();
        valToIndex.erase(val);
        return true;
    }

    int getRandom() {
        return vals[rand() % vals.size()];
    }
};