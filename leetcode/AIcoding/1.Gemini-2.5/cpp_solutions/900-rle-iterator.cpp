#include <vector>

class RLEIterator {
private:
    std::vector<int> data;
    int current_pair_index;
    long long current_pair_elements_consumed;

public:
    RLEIterator(std::vector<int>& A) {
        data = A;
        current_pair_index = 0;
        current_pair_elements_consumed = 0;
    }

    int next(int n) {
        while (n > 0 && current_pair_index < data.size()) {
            long long current_pair_total_count = data[current_pair_index];
            int current_pair_value = data[current_pair_index + 1];

            long long remaining_in_current_pair = current_pair_total_count - current_pair_elements_consumed;

            if (n <= remaining_in_current_pair) {
                current_pair_elements_consumed += n;
                n = 0;
                return current_pair_value;
            } else {
                n -= remaining_in_current_pair;
                current_pair_index += 2;
                current_pair_elements_consumed = 0;
            }
        }

        return -1;
    }
};