#include <unordered_map>
#include <set>

using namespace std;

class NumberContainers {
public:
    unordered_map<int, int> num_to_index;
    unordered_map<int, set<int>> index_to_nums;

    NumberContainers() {

    }

    void change(int index, int number) {
        if (num_to_index.count(index)) {
            int old_num = num_to_index[index];
            index_to_nums[old_num].erase(index);
            if (index_to_nums[old_num].empty()) {
                index_to_nums.erase(old_num);
            }
        }
        num_to_index[index] = number;
        index_to_nums[number].insert(index);
    }

    int find(int number) {
        if (index_to_nums.count(number) == 0) {
            return -1;
        }
        return *index_to_nums[number].begin();
    }
};