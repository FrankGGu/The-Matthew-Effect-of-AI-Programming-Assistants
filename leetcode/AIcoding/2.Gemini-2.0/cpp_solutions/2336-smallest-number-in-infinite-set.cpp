#include <set>

class SmallestInfiniteSet {
private:
    std::set<int> added;
    int current;

public:
    SmallestInfiniteSet() {
        current = 1;
    }

    int popSmallest() {
        if (added.empty()) {
            return current++;
        } else {
            int smallest = *added.begin();
            if (smallest < current) {
                added.erase(added.begin());
                return smallest;
            } else {
                return current++;
            }
        }
    }

    void addBack(int num) {
        if (num < current) {
            added.insert(num);
        }
    }
};