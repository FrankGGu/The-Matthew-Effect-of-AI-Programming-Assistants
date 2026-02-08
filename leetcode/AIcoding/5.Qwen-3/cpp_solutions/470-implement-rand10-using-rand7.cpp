#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int rand10() {
        int row, col, idx;
        do {
            row = rand7();
            col = rand7();
            idx = (row - 1) * 7 + col;
        } while (idx > 40);
        return idx % 10 + 1;
    }

private:
    int rand7() {
        return rand() % 7 + 1;
    }
};