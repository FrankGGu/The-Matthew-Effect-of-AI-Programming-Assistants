#include <vector>
#include <unordered_map>
#include <cstdlib> // For std::rand

class RandomizedSet {
private:
    std::vector<int> vals;
    std::unordered_map<int, int> val_to_idx;

public:
    RandomizedSet() {
        // Constructor, no special initialization needed for std::rand()
        // LeetCode environment usually handles seeding for std::rand()
        // or it's implicitly assumed for problem constraints.
    }

    bool insert(int val) {
        if (val_to_idx.count(val)) {
            return false;
        }

        vals.push_back(val);
        val_to_idx[val] = vals.size() - 1;
        return true;
    }

    bool remove(int val) {
        if (!val_to_idx.count(val)) {
            return false;
        }

        int idx_to_remove = val_to_idx[val];
        int last_val = vals.back();

        // Move the last element to the position of the element to be removed
        vals[idx_to_remove] = last_val;
        val_to_idx[last_val] = idx_to_remove;

        // Remove the entry for 'val' from the map
        val_to_idx.erase(val);

        // Remove the last element from the vector (which is now a duplicate of the moved element, or the original val if it was last)
        vals.pop_back();

        return true;
    }

    int getRandom() {
        // Generate a random index within the current size of the vector
        // std::rand() % N gives a number in [0, N-1]
        return vals[std::rand() % vals.size()];
    }
};