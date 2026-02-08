#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxNumberOfGroups() {
        vector<int> counts(101, 0);
        for (int i = 2; i <= 100; ++i) {
            for (int j = i; j <= 100; j += i) {
                counts[j]++;
            }
        }
        int res = 0;
        for (int i = 1; i <= 100; ++i) {
            if (counts[i] >= 2) {
                res++;
            }
        }
        return res;
    }
};