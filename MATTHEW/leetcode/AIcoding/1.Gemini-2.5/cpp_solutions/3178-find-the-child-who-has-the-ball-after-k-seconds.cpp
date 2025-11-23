class Solution {
public:
    int numberOfChild(int n, int k) {
        int cycle_len = 2 * (n - 1);
        int time_in_cycle = k % cycle_len;

        if (time_in_cycle <= n - 1) {
            return time_in_cycle;
        } else {
            return (n - 1) - (time_in_cycle - (n - 1));
        }
    }
};