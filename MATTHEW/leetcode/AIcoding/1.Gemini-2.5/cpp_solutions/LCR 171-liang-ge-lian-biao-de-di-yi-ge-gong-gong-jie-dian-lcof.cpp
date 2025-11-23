#include <vector>
#include <queue>
#include <functional>

class KthLargest {
public:
    KthLargest(int k, std::vector<int>& nums) : k_(k) {
        for (int num : nums) {
            add(num);
        }
    }

    int add(int val) {
        pq_.push(val);
        if (pq_.size() > k_) {
            pq_.pop();
        }
        return pq_.top();
    }

private:
    int k_;
    std::priority_queue<int, std::vector<int>, std::greater<int>> pq_;
};