class Solution {
public:
    int minimumSwaps(string s) {
        int open = 0, close = 0;
        for (char c : s) {
            if (c == '[') open++;
            else close++;
        }
        if (open != close) return -1;

        int balance = 0, swaps = 0;
        for (char c : s) {
            if (c == '[') balance++;
            else balance--;
            if (balance < 0) {
                swaps++;
                balance = 1; // reset balance since we perform a swap
            }
        }
        return swaps;
    }
};