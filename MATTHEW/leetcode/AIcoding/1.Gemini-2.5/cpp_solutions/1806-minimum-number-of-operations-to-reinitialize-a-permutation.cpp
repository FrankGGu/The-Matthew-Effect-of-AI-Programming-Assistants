class Solution {
public:
    int reinitializePermutation(int n) {
        int current_idx_of_one = 1;
        int operations = 0;

        do {
            operations++;
            if (current_idx_of_one < n / 2) {
                current_idx_of_one *= 2;
            } else {
                current_idx_of_one = 2 * current_idx_of_one - (n - 1);
            }
        } while (current_idx_of_one != 1);

        return operations;
    }
};