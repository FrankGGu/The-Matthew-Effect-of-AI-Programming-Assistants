#include <queue>

class MovingAverage {
private:
    std::queue<int> q;
    int size;
    double sum;

public:

    MovingAverage(int size) {
        this->size = size;
        this->sum = 0.0;
    }

    double next(int val) {
        if (q.size() == size) {
            sum -= q.front();
            q.pop();
        }
        q.push(val);
        sum += val;
        return sum / q.size();
    }
};