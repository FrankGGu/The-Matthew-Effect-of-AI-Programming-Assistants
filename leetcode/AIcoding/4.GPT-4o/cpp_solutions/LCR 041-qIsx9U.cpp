class MovingAverage {
public:

    MovingAverage(int size) {
        this->size = size;
    }

    double next(int val) {
        if (values.size() == size) {
            sum -= values.front();
            values.pop();
        }
        values.push(val);
        sum += val;
        return sum / values.size();
    }

private:
    queue<int> values;
    double sum = 0;
    int size;
};