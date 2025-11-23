#include <string>
#include <vector>
#include <queue>
#include <functional> // For std::greater

using Place = std::pair<int, std::string>;

class SORTracker {
private:
    // max_heap_top_k: A max-heap that stores the 'k' best elements.
    // Its top element will be the 'k'-th best place (the worst among the top 'k').
    // Since Place stores (-score, name), a max-heap will put the lexicographically largest
    // pair at the top, which corresponds to the 'k'-th best element.
    std::priority_queue<Place> max_heap_top_k;

    // min_heap_rest: A min-heap that stores all elements worse than the 'k'-th best.
    // Its top element will be the best among these 'rest' elements (the (k+1)-th best overall).
    // Since Place stores (-score, name), a min-heap will put the lexicographically smallest
    // pair at the top, which corresponds to the best among the 'rest'.
    std::priority_queue<Place, std::vector<Place>, std::greater<Place>> min_heap_rest;

    int current_get_count;

public:
    SORTracker() : current_get_count(0) {}

    void add(std::string name, int score) {
        Place p = {-score, name};

        // If max_heap_top_k is empty or the new place is better than the current k-th best place
        // (which is max_heap_top_k.top()), add it to max_heap_top_k.
        // Otherwise, add it to min_heap_rest.
        if (max_heap_top_k.empty() || p < max_heap_top_k.top()) {
            max_heap_top_k.push(p);
        } else {
            min_heap_rest.push(p);
        }

        // Maintain the invariant: max_heap_top_k.top() should not be worse than min_heap_rest.top().
        // If it is, swap them.
        // This ensures that all elements in max_heap_top_k are better than or equal to
        // all elements in min_heap_rest.
        if (!max_heap_top_k.empty() && !min_heap_rest.empty() && max_heap_top_k.top() > min_heap_rest.top()) {
            Place p_top_k = max_heap_top_k.top();
            max_heap_top_k.pop();
            Place p_rest = min_heap_rest.top();
            min_heap_rest.pop();

            max_heap_top_k.push(p_rest);
            min_heap_rest.push(p_top_k);
        }
    }

    std::string get() {
        current_get_count++;

        // Balance the heaps: max_heap_top_k should contain exactly 'current_get_count' elements.
        // If max_heap_top_k is too small, move elements from min_heap_rest.
        while (max_heap_top_k.size() < current_get_count) {
            max_heap_top_k.push(min_heap_rest.top());
            min_heap_rest.pop();
        }
        // If max_heap_top_k is too large, move elements to min_heap_rest.
        while (max_heap_top_k.size() > current_get_count) {
            min_heap_rest.push(max_heap_top_k.top());
            max_heap_top_k.pop();
        }

        // The 'current_get_count'-th best place is now at the top of max_heap_top_k.
        return max_heap_top_k.top().second;
    }
};