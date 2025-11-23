#include <vector>
#include <unordered_map>
#include <random>

using namespace std;

class Solution {
public:
    Solution(int n_rows, int n_cols) : rows(n_rows), cols(n_cols), total(n_rows * n_cols) {
        random_engine.seed(random_device{}());
    }

    vector<int> flip() {
        int index = generate_random_index();
        int original_index = index;

        if (index_map.count(index)) {
            index = index_map[index];
        }

        int last_index = total - 1;

        int original_last_index = last_index;

        if (index_map.count(last_index)) {
            last_index = index_map[last_index];
        }

        index_map[original_index] = last_index;

        total--;

        return {index / cols, index % cols};
    }

    void reset() {
        total = rows * cols;
        index_map.clear();
    }

private:
    int rows;
    int cols;
    int total;
    unordered_map<int, int> index_map;
    mt19937 random_engine;

    int generate_random_index() {
        uniform_int_distribution<int> distribution(0, total - 1);
        return distribution(random_engine);
    }
};