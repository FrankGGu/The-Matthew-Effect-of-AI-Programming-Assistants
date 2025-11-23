#include <vector>
#include <numeric>
#include <algorithm>

class ATM {
private:
    long long current_banknotes[5]; // Stores counts of 20, 50, 100, 200, 500 notes
    long long denominations_values[5] = {20, 50, 100, 200, 500};

public:
    ATM() {
        for (int i = 0; i < 5; ++i) {
            current_banknotes[i] = 0;
        }
    }

    void deposit(std::vector<int> banknotesCount) {
        for (int i = 0; i < 5; ++i) {
            current_banknotes[i] += banknotesCount[i];
        }
    }

    std::vector<int> withdraw(int amount_int) {
        long long amount = amount_int; // Use long long for amount in calculations to prevent overflow
        std::vector<int> withdrawn_notes_result(5, 0); // To store the notes to be returned

        // Iterate from largest denomination to smallest
        for (int i = 4; i >= 0; --i) {
            if (amount == 0) {
                break;
            }

            long long denom = denominations_values[i];
            long long count_available = current_banknotes[i];

            // Calculate how many notes of this denomination we can take
            // It's the minimum of (notes needed for remaining amount) and (notes actually available)
            long long notes_to_take = std::min(amount / denom, count_available);

            amount -= notes_to_take * denom;
            withdrawn_notes_result[i] = (int)notes_to_take; // Store as int for return
        }

        if (amount == 0) { // Successfully withdrew the amount
            // Update the actual available notes in the ATM
            for (int i = 0; i < 5; ++i) {
                current_banknotes[i] -= withdrawn_notes_result[i];
            }
            return withdrawn_notes_result;
        } else { // Cannot withdraw the exact amount
            return {-1}; // LeetCode expects {-1} for failure
        }
    }
};