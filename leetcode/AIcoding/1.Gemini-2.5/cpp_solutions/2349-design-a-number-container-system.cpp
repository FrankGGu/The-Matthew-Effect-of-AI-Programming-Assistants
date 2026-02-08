#include <map>
#include <set>

class NumberContainers {
public:
    std::map<int, int> index_to_number_map;
    std::map<int, std::set<int>> number_to_indices_map;

    NumberContainers() {

    }

    void change(int index, int number) {
        if (index_to_number_map.count(index)) {
            int old_number = index_to_number_map[index];
            number_to_indices_map[old_number].erase(index);
            if (number_to_indices_map[old_number].empty()) {
                number_to_indices_map.erase(old_number);
            }
        }

        index_to_number_map[index] = number;
        number_to_indices_map[number].insert(index);
    }

    int find(int number) {
        if (number_to_indices_map.count(number)) {
            return *number_to_indices_map[number].begin();
        } else {
            return -1;
        }
    }
};