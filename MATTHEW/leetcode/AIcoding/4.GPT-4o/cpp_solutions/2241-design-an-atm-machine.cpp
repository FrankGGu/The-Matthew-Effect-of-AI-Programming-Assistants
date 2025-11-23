class ATM {
public:
    vector<long long> banknotes = {20, 50, 100, 200, 500};
    vector<long long> counts = {0, 0, 0, 0, 0};
    long long total = 0;

    ATM() {}

    void deposit(vector<int> banknotes) {
        for (int i = 0; i < 5; i++) {
            counts[i] += banknotes[i];
            total += counts[i] * this->banknotes[i];
        }
    }

    vector<int> withdraw(int amount) {
        if (amount > total) return {-1};
        vector<int> result(5, 0);

        for (int i = 4; i >= 0; i--) {
            if (amount <= 0) break;
            long long take = min(amount / banknotes[i], counts[i]);
            result[i] = take;
            amount -= take * banknotes[i];
        }

        if (amount > 0) return {-1};

        for (int i = 0; i < 5; i++) {
            counts[i] -= result[i];
        }
        total -= accumulate(result.begin(), result.end(), 0LL, [&](long long sum, int count) {
            return sum + count * banknotes[result - result.begin()];
        });

        return result;
    }
};