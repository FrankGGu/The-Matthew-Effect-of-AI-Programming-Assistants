#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int getX(int n, vector<int>& a, vector<int>& b) {
        for (int x = 0; x <= n; ++x) {
            bool valid = true;
            for (int i = 0; i < a.size(); ++i) {
                if (a[i] + b[i] != x) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                return x;
            }
        }
        return -1;
    }
};