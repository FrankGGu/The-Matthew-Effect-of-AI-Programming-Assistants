#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int maxProfit(int x, int y, vector<int>& customers) {
        int n = customers.size();
        int total = 0;
        int wait = 0;
        for (int i = 0; i < n; ++i) {
            if (wait > 0) {
                wait--;
            } else {
                if (customers[i] >= x) {
                    total += y;
                    wait = x - 1;
                }
            }
        }
        return total;
    }
};