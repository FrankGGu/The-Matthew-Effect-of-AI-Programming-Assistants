#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(int k) {
        if (k == 0) return 0;
        int operations = 0;
        int current = 1;
        while (current < k) {
            current += current;
            operations++;
        }
        return operations;
    }
};