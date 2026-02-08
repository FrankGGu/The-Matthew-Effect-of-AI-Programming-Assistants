#include <vector>
#include <queue>
#include <functional> // Not strictly needed for std::priority_queue with default comparator

class Solution {
public:
    long long makeArrayNonDecreasing(std::vector<int>& nums) {
        long long total_cost = 0;
        // A max-priority queue is used to keep track of elements
        // that are part of the currently constructed non-decreasing sequence.
        // The top element is the largest among them.
        std::priority_queue<long long> max_heap;

        for (long long num : nums) {
            // Always add the current number to the heap.
            // This conceptually adds 'num' as a candidate for an element in the non-decreasing sequence.
            max_heap.push(num);

            // If the current number 'num' is smaller than the largest element currently in our heap,
            // it means we have a violation of the non-decreasing property (max_heap.top() > num).
            // To fix this, we must change the larger element (max_heap.top()) to 'num'.
            // The cost incurred for this specific change is max_heap.top() - num.
            if (num < max_heap.top()) {
                total_cost += max_heap.top() - num;
                // Remove the larger element from the heap.
                max_heap.pop();
                // Add 'num' back to the heap. This effectively replaces the larger element with 'num'.
                // Since 'num' was already pushed once, it is now in the heap twice.
                // This is crucial for the correctness of this specific algorithm, as it
                // allows 'num' to potentially be chosen multiple times for the final non-decreasing sequence.
                max_heap.push(num);
            }
        }
        return total_cost;
    }
};