#include <set>

class SmallestInfiniteSet {
public:
    SmallestInfiniteSet() : next_num(1) {}

    int popSmallest() {
        if (!available.empty()) {
            int smallest = *available.begin();
            available.erase(available.begin());
            return smallest;
        }
        return next_num++;
    }

    void addBack(int num) {
        if (num < next_num) {
            available.insert(num);
        }
    }

private:
    int next_num;
    std::set<int> available;
};