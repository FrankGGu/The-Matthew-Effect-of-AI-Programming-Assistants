#include <set>
#include <queue>
#include <vector>
#include <functional>

class SmallestInfiniteSet {
private:
    std::priority_queue<int, std::vector<int>, std::greater<int>> min_heap;
    std::set<int> added_back_set;
    int current_num;

public:
    SmallestInfiniteSet() {
        current_num = 1;
    }

    int popSmallest() {
        if (!min_heap.empty()) {
            int smallest = min_heap.top();
            min_heap.pop();
            added_back_set.erase(smallest);
            return smallest;
        } else {
            int smallest = current_num;
            current_num++;
            return smallest;
        }
    }

    void addBack(int num) {
        if (num < current_num && added_back_set.find(num) == added_back_set.end()) {
            min_heap.push(num);
            added_back_set.insert(num);
        }
    }
};