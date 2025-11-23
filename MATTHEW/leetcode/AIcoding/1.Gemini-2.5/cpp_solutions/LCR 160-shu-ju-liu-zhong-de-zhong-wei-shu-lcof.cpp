#include <queue>
#include <vector>
#include <functional>

class MedianFinder {
public:
    std::priority_queue<int> max_heap; // Stores the smaller half of numbers (max-heap)
    std::priority_queue<int, std::vector<int>, std::greater<int>> min_heap; // Stores the larger half of numbers (min-heap)

    MedianFinder() {

    }

    void addNum(int num) {
        if (max_heap.empty() || num <= max_heap.top()) {
            max_heap.push(num);
        } else {
            min_heap.push(num);
        }

        // Balance the heaps
        // Ensure max_heap.size() is equal to min_heap.size() or max_heap.size() == min_heap.size() + 1
        if (max_heap.size() > min_heap.size() + 1) {
            min_heap.push(max_heap.top());
            max_heap.pop();
        } else if (min_heap.size() > max_heap.size()) {
            max_heap.push(min_heap.top());
            min_heap.pop();
        }
    }

    double findMedian() {
        if (max_heap.size() == min_heap.size()) {
            return (static_cast<double>(max_heap.top()) + min_heap.top()) / 2.0;
        } else {
            return static_cast<double>(max_heap.top());
        }
    }
};