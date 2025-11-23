#include <vector>
#include <unordered_map>
#include <cstdlib>

class Solution {
    std::unordered_map<int, int> map;
    int m_rows, n_cols, available_count;

public:
    Solution(int m, int n) : m_rows(m), n_cols(n), available_count(m * n) {}

    std::vector<int> flip() {
        int r = rand() % available_count;
        available_count--;

        int val_to_return = r;
        if (map.count(r)) {
            val_to_return = map[r];
        }

        int last_val = available_count;
        if (map.count(available_count)) {
            last_val = map[available_count];
        }

        map[r] = last_val;

        return {val_to_return / n_cols, val_to_return % n_cols};
    }

    void reset() {
        map.clear();
        available_count = m_rows * n_cols;
    }
};