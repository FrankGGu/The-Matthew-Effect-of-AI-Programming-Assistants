#include <string>
#include <algorithm>

class Solution {
public:
    std::string maxValue(std::string n, int x) {
        char char_x = x + '0';

        if (n[0] == '-') {
            // For a negative number, to maximize it, we want to make its absolute value as small as possible.
            // This means inserting 'x' at the first position where 'x' is smaller than the current digit.
            // We start searching from index 1 (after the minus sign).
            int i = 1;
            while (i < n.length() && char_x >= n[i]) {
                i++;
            }
            n.insert(i, 1, char_x);
        } else {
            // For a positive number, to maximize it, we want to make the number as large as possible.
            // This means inserting 'x' at the first position where 'x' is larger than the current digit.
            // We start searching from index 0.
            int i = 0;
            while (i < n.length() && char_x <= n[i]) {
                i++;
            }
            n.insert(i, 1, char_x);
        }

        return n;
    }
};