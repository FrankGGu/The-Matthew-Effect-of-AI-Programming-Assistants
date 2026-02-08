class DataStream {
private:
    int value;
    int k;
    int count;

public:
    DataStream(int value, int k) : value(value), k(k), count(0) {}

    bool consec(int num) {
        if (num == value) {
            count++;
        } else {
            count = 0;
        }
        return count >= k;
    }
};