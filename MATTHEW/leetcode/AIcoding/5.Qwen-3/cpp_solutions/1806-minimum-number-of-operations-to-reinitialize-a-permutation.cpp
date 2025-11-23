#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int reinitializePermutation(int n) {
        vector<int> pos(n);
        for (int i = 0; i < n; ++i) {
            pos[i] = i;
        }

        int ops = 0;
        int i = 1;
        while (true) {
            if (i == 1) {
                break;
            }
            if (i % 2 == 0) {
                i /= 2;
            } else {
                i = (n - 1) / 2 + (i + 1) / 2;
            }
            ++ops;
        }

        return ops;
    }
};