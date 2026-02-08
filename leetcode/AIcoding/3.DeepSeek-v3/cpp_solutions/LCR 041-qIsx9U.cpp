#include <queue>
using namespace std;

class MovingAverage {
private:
    queue<int> q;
    int maxSize;
    double sum;
public:
    MovingAverage(int size) {
        maxSize = size;
        sum = 0.0;
    }

    double next(int val) {
        q.push(val);
        sum += val;
        if (q.size() > maxSize) {
            sum -= q.front();
            q.pop();
        }
        return sum / q.size();
    }
};