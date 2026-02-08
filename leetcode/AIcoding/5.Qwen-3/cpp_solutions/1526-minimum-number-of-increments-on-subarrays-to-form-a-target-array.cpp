#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minNumberOperations(vector<int>& target) {
        int operations = 0;
        int prev = 0;
        for (int t : target) {
            if (t > prev) {
                operations += t - prev;
            }
            prev = t;
        }
        return operations;
    }
};