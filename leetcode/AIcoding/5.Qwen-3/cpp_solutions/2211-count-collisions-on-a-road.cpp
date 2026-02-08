#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countCollisions(string directions) {
        int n = directions.size();
        int i = 0;
        while (i < n && directions[i] == 'L') {
            ++i;
        }
        if (i == n) return 0;
        int count = 0;
        for (int j = i + 1; j < n; ++j) {
            if (directions[j] == 'L') {
                count += 1;
            } else if (directions[j] == 'R') {
                count += 1;
            } else {
                count += 1;
                break;
            }
        }
        return count;
    }
};