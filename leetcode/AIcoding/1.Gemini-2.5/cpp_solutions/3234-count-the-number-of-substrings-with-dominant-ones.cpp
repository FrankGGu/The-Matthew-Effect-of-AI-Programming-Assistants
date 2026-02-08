#include <string>
#include <vector>

class FenwickTree {
private:
    std::vector<long long> bit;
    int size;

public:
    FenwickTree(int s) : size(s), bit(s + 1, 0) {}

    void update(int idx, int val) {
        // idx is 0-based for balance values, convert to 1-based for BIT
        idx++; 
        while (idx <= size) {
            bit[idx] += val;
            idx += idx & (-idx);
        }
    }

    long long query(int idx) {
        // idx is 0-based for balance values, convert to 1-based for BIT
        idx++; 
        long long sum = 0;
        while (idx > 0) {
            sum += bit[idx];
            idx -= idx & (-idx);
        }
        return sum;
    }
};

class Solution {
public:
    long long numberOfSubstrings(std::string s) {
        int n = s.length();
        long long ans = 0;
        int balance = 0; // current balance (count1 - count0)

        // Offset to map balance values [-n, n] to [0, 2n]
        // The minimum balance is -n, max is n.
        // So mapped values range from 0 to 2n.
        // The Fenwick tree needs to cover indices up to 2n.
        int offset = n; 

        // Fenwick tree size needs to cover indices from 0 to 2*n.
        // If max index is M, BIT array size is M+1. Here max index is 2*n.
        FenwickTree ft(2 * n); 

        // Initial state: prefix before index 0 has balance 0.
        // Add 1 to the frequency of balance 0.
        ft.update(balance + offset, 1);

        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                balance++;
            } else {
                balance--;
            }

            // We are looking for substrings s[k...i] where count1 >= count0.
            // This is equivalent to (pref_count1[i] - pref_count1[k-1]) >= (pref_count0[i] - pref_count0[k-1])
            // Rearranging, (pref_count1[i] - pref_count0[i]) >= (pref_count1[k-1] - pref_count0[k-1])
            // Let pref_balance[x] = pref_count1[x] - pref_count0[x].
            // We need pref_balance[i] >= pref_balance[k-1].
            // For the current 'i', we query the Fenwick tree for all previous prefix balances (pref_balance[k-1])
            // that are less than or equal to the current pref_balance[i].
            ans += ft.query(balance + offset);

            // Add the current prefix balance to the Fenwick tree.
            ft.update(balance + offset, 1);
        }

        return ans;
    }
};