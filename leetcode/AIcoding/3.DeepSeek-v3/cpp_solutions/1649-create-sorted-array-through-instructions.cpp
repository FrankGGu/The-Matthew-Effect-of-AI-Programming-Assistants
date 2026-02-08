#include <vector>
#include <algorithm>

class FenwickTree {
private:
    std::vector<int> tree;
public:
    FenwickTree(int size) : tree(size + 1, 0) {}

    void update(int index, int delta) {
        for (; index < tree.size(); index += index & -index) {
            tree[index] += delta;
        }
    }

    int query(int index) {
        int sum = 0;
        for (; index > 0; index -= index & -index) {
            sum += tree[index];
        }
        return sum;
    }
};

class Solution {
public:
    int createSortedArray(std::vector<int>& instructions) {
        const int MOD = 1e9 + 7;
        int max_val = *std::max_element(instructions.begin(), instructions.end());
        FenwickTree ft(max_val);
        long long cost = 0;

        for (int i = 0; i < instructions.size(); ++i) {
            int num = instructions[i];
            int less = ft.query(num - 1);
            int greater = i - ft.query(num);
            cost += std::min(less, greater);
            cost %= MOD;
            ft.update(num, 1);
        }

        return cost;
    }
};