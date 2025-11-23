class ATM {
private:
    vector<long long> notes;
    vector<int> denominations;

public:
    ATM() {
        notes.resize(5, 0);
        denominations = {20, 50, 100, 200, 500};
    }

    void deposit(vector<int> banknotesCount) {
        for (int i = 0; i < 5; ++i) {
            notes[i] += banknotesCount[i];
        }
    }

    vector<int> withdraw(int amount) {
        vector<int> result(5, 0);
        vector<long long> temp = notes;
        for (int i = 4; i >= 0; --i) {
            if (amount >= denominations[i] && temp[i] > 0) {
                int cnt = min((long long)(amount / denominations[i]), temp[i]);
                amount -= cnt * denominations[i];
                result[i] = cnt;
                temp[i] -= cnt;
            }
        }
        if (amount != 0) {
            return {-1};
        }
        notes = temp;
        return result;
    }
};