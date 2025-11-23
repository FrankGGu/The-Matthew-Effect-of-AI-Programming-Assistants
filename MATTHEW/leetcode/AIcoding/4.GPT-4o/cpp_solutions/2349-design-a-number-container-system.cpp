#include <unordered_map>
#include <set>
#include <vector>

class NumberContainers {
public:
    NumberContainers() {}

    void change(int index, int number) {
        if (indexToNumber.count(index)) {
            int oldNumber = indexToNumber[index];
            numberToIndexes[oldNumber].erase(index);
            if (numberToIndexes[oldNumber].empty()) {
                numberToIndexes.erase(oldNumber);
            }
        }
        indexToNumber[index] = number;
        numberToIndexes[number].insert(index);
    }

    int find(int number) {
        if (numberToIndexes.count(number) && !numberToIndexes[number].empty()) {
            return *numberToIndexes[number].begin();
        }
        return -1;
    }

private:
    std::unordered_map<int, int> indexToNumber;
    std::unordered_map<int, std::set<int>> numberToIndexes;
};