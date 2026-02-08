#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int aliceAndBobGame(int n) {
        int count = 0;
        for (int i = 1; i <= n; i++) {
            if (i % 2 == 1) {
                count++;
            }
        }
        return count % 2;
    }
};