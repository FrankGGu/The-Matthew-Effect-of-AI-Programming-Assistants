#include <vector>

class RLEIterator {
private:
    std::vector<int> A;
    int index;
    int count;

public:
    RLEIterator(std::vector<int>& A) {
        this->A = A;
        index = 0;
        count = 0;
    }

    int next(int n) {
        while (index < A.size()) {
            if (count == 0) {
                count = A[index];
            }

            if (n <= count) {
                count -= n;
                return A[index + 1];
            } else {
                n -= count;
                count = 0;
                index += 2;
            }
        }

        return -1;
    }
};