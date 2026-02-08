#include <vector>

class NeighborSumService {
private:
    std::vector<int> arr;
    int n;

public:
    NeighborSumService(int capacity) {
        n = capacity;
        arr.resize(n, 0);
    }

    void set(int index, int val) {
        if (index >= 0 && index < n) {
            arr[index] = val;
        }
    }

    int getNeighborSum(int index) {
        if (index < 0 || index >= n) {
            return 0;
        }

        if (n <= 1) {
            return 0;
        }

        int sum = 0;
        if (index > 0) {
            sum += arr[index - 1];
        }
        if (index < n - 1) {
            sum += arr[index + 1];
        }
        return sum;
    }
};