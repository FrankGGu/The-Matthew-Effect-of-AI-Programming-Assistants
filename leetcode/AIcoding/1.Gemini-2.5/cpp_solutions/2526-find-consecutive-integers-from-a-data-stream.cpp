class DataStream {
private:
    int targetValue;
    int consecutiveCount;
    int requiredK;

public:
    DataStream(int value, int k) {
        targetValue = value;
        requiredK = k;
        consecutiveCount = 0;
    }

    bool consec(int num) {
        if (num == targetValue) {
            consecutiveCount++;
        } else {
            consecutiveCount = 0;
        }
        return consecutiveCount >= requiredK;
    }
};