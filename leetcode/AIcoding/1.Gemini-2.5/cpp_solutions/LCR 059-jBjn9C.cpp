#include <vector>
#include <queue>
#include <functional> // Required for std::greater

class KthLargest {
private:
    std::priority_queue<int, std::vector<int>, std::greater<int>> min_heap;
    int k_val;

public:
    KthLargest(int k, std::vector<int>& nums) {
        k_val = k;
        for (int num : nums) {
            add(num);
        }
    }

    int add(int val) {
        min_heap.push(val);
        if (min_heap.size() > k_val) {
            min_heap.pop();
        }
        return min_heap.top();
    }
};