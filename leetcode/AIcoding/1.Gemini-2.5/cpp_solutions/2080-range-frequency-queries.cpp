#include <vector>
#include <unordered_map>
#include <algorithm>
#include <iterator>

class RangeFreqQuery {
private:
    std::unordered_map<int, std::vector<int>> val_to_indices;

public:
    RangeFreqQuery(std::vector<int>& arr) {
        for (int i = 0; i < arr.size(); ++i) {
            val_to_indices[arr[i]].push_back(i);
        }
    }

    int query(int left, int right, int value) {
        if (val_to_indices.find(value) == val_to_indices.end()) {
            return 0;
        }

        const std::vector<int>& indices = val_to_indices.at(value);

        auto it_left = std::lower_bound(indices.begin(), indices.end(), left);
        auto it_right = std::upper_bound(indices.begin(), indices.end(), right);

        return std::distance(it_left, it_right);
    }
};