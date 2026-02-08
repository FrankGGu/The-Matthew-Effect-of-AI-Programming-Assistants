#include <queue>

class KthLargest {
public:
    KthLargest(int k, vector<int>& nums) : k_(k) {
        for (int num : nums) {
            pq_.push(num);
            if (pq_.size() > k_) {
                pq_.pop();
            }
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
    priority_queue<int, vector<int>, greater<int>> pq_;
};