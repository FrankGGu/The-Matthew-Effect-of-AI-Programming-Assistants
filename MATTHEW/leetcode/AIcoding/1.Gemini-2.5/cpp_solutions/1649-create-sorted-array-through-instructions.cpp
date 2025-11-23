#include <vector>
#include <algorithm>

class FenwickTree {
private:
    std::vector<int> bit;
    int size;

public:
    FenwickTree(int s) : size(s), bit(s + 1, 0) {}

    void update(int idx, int delta) {
        for (; idx <= size; idx += idx & (-idx)) {
            bit[idx] += delta;
        }
    }

    int query(int idx) {
        int sum = 0;
        for (; idx > 0; idx -= idx & (-idx)) {
            sum += bit[idx];
        }
        return sum;
    }
};

class Solution {
public:
    int createSortedArray(std::vector<int>& instructions) {
        const int MAX_VAL = 100000;
        const int MOD = 1e9 + 7;

        FenwickTree ft(MAX_VAL);
        long long total_cost = 0;

        for (int i = 0; i < instructions.size(); ++i) {
            int num = instructions[i];

            int count_smaller = ft.query(num - 1);

            int count_less_equal = ft.query(num);

            int count_larger = i - count_less_equal;

            total_cost = (total_cost + std::min(count_smaller, count_larger)) % MOD;

            ft.update(num, 1);
        }

        return static_cast<int>(total_cost);
    }
};