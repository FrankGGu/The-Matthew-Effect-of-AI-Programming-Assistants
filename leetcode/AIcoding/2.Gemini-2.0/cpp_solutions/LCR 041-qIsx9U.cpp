#include <queue>

class MovingAverage {
public:
    MovingAverage(int size) : size_(size) {}

    double next(int val) {
        queue_.push(val);
        sum_ += val;
        if (queue_.size() > size_) {
            sum_ -= queue_.front();
            queue_.pop();
        }
        return static_cast<double>(sum_) / queue_.size();
    }

private:
    std::queue<int> queue_;
    int size_;
    double sum_ = 0.0;
};