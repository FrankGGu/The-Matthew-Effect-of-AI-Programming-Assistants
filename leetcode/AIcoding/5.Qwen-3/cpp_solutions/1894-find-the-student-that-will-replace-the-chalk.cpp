#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int chalkReplacer(vector<int>& chalks, int k) {
        long long sum = 0;
        for (int ch : chalks) {
            sum += ch;
        }
        k %= sum;
        for (int i = 0; i < chalks.size(); ++i) {
            if (k < chalks[i]) {
                return i;
            }
            k -= chalks[i];
        }
        return -1;
    }
};