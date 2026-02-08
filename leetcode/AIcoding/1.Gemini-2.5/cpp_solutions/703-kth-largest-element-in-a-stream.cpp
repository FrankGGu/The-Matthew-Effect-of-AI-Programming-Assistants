#include <vector>
#include <queue>
#include <functional>

class KthLargest {
private:
    int k_val;
    std::priority_queue<int, std::vector<int>, std::greater<int>> min_heap;

public:
    KthLargest(int k, std::vector<int>& nums) {
        k_val = k;
        for (int num : nums) {
            add(num);
        }
    }

    int add(int val) {
        if (min_heap.size() < k_val) {
            min_heap.push(val);
        } else if (val > min_heap.top()) {
            min_heap.pop();
            min_heap.push(val);
        }
        return min_heap.top();
    }
};