#include <iostream>
#include <vector>
#include <map>
#include <numeric>

using namespace std;

class Solution {
public:
    bool hasGroupsSizeX(vector<int>& deck) {
        map<int, int> count;
        for (int card : deck) {
            count[card]++;
        }

        int gcdVal = 0;
        for (auto& pair : count) {
            gcdVal = gcd(gcdVal, pair.second);
        }

        return gcdVal >= 2;
    }
};