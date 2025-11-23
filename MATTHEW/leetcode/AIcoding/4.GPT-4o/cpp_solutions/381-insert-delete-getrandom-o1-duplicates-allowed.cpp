#include <unordered_map>
#include <vector>
#include <cstdlib>

class RandomizedCollection {
public:
    std::unordered_map<int, std::vector<int>> valMap;
    std::vector<int> values;

    RandomizedCollection() {

    }

    bool insert(int val) {
        values.push_back(val);
        valMap[val].push_back(values.size() - 1);
        return valMap[val].size() == 1;
    }

    bool remove(int val) {
        if (valMap.find(val) == valMap.end() || valMap[val].empty()) {
            return false;
        }

        int lastIndex = values.size() - 1;
        int removeIndex = valMap[val].back();
        valMap[val].pop_back();

        if (removeIndex < lastIndex) {
            int lastValue = values[lastIndex];
            values[removeIndex] = lastValue;
            valMap[lastValue].back() = removeIndex;
        }

        values.pop_back();
        if (valMap[val].empty()) {
            valMap.erase(val);
        }

        return true;
    }

    int getRandom() {
        return values[rand() % values.size()];
    }
};