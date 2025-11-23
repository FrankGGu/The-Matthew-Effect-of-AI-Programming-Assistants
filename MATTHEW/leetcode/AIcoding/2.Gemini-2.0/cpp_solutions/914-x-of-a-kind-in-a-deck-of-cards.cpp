#include <vector>
#include <numeric>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    bool hasGroupsSizeX(vector<int>& deck) {
        map<int, int> counts;
        for (int card : deck) {
            counts[card]++;
        }

        int commonGCD = 0;
        for (auto const& [key, val] : counts) {
            if (commonGCD == 0) {
                commonGCD = val;
            } else {
                commonGCD = gcd(commonGCD, val);
            }
        }

        return commonGCD >= 2;
    }
};