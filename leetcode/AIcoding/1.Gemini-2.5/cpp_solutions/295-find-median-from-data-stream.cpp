#include <queue>
#include <vector>
#include <functional>

class MedianFinder {
public:
    std::priority_queue<int> max_heap_low; // Stores the smaller half, max-heap
    std::priority_queue<int, std::vector<int>, std::greater<int>> min_heap_high; // Stores the larger half, min-heap

    MedianFinder() {

    }

    void addNum(int num) {
        if (max_heap_low.empty() || num <= max_heap_low.top()) {
            max_heap_low.push(num);
        } else {
            min_heap_high.push(num);
        }

        // Balance the heaps
        // Ensure max_heap_low has at most one more element than min_heap_high
        if (max_heap_low.size() > min_heap_high.size() + 1) {
            min_heap_high.push(max_heap_low.top());
            max_heap_low.pop();
        } 
        // Ensure min_heap_high does not have more elements than max_heap_low
        else if (min_heap_high.size() > max_heap_low.size()) {
            max_heap_low.push(min_heap_high.top());
            min_heap_high.pop();
        }
    }

    double findMedian() {
        if (max_heap_low.empty()) {
            return 0.0; // Or throw an error, depending on problem constraints for empty stream
        }

        if (max_heap_low.size() == min_heap_high.size()) {
            // Even number of elements, median is the average of the two middle elements
            return (static_cast<double>(max_heap_low.top()) + min_heap_high.top()) / 2.0;
        } else {
            // Odd number of elements, median is the top of max_heap_low
            return static_cast<double>(max_heap_low.top());
        }
    }
};