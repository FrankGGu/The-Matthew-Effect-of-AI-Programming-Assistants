#include <vector>

class ATM {
public:
    ATM() {
        counts = std::vector<long long>(5, 0);
        values = {20, 50, 100, 200, 500};
    }

    void deposit(std::vector<int> banknotesCount) {
        for (int i = 0; i < 5; ++i) {
            counts[i] += banknotesCount[i];
        }
    }

    std::vector<int> withdraw(int amount) {
        std::vector<int> result(5, 0);
        std::vector<long long> temp_counts = counts;

        for (int i = 4; i >= 0; --i) {
            long long num = std::min((long long)amount / values[i], temp_counts[i]);
            result[i] = num;
            amount -= num * values[i];
            temp_counts[i] -= num;
        }

        if (amount != 0) {
            return {-1};
        }

        counts = temp_counts;
        return result;
    }

private:
    std::vector<long long> counts;
    std::vector<int> values;
};