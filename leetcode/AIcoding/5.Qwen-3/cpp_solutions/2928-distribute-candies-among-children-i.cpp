#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int distributeCandies(int n, int limit) {
        int count = 0;
        for (int i = 0; i <= limit && i <= n; ++i) {
            for (int j = 0; j <= limit && i + j <= n; ++j) {
                int remaining = n - i - j;
                if (remaining <= limit) {
                    ++count;
                }
            }
        }
        return count;
    }
};