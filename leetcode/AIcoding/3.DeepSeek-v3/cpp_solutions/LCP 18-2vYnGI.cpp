#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int breakfastNumber(vector<int>& staple, vector<int>& drinks, int x) {
        sort(staple.begin(), staple.end());
        sort(drinks.begin(), drinks.end());
        int res = 0;
        int mod = 1e9 + 7;
        int i = 0;
        int j = drinks.size() - 1;
        while (i < staple.size() && j >= 0) {
            if (staple[i] + drinks[j] <= x) {
                res = (res + j + 1) % mod;
                i++;
            } else {
                j--;
            }
        }
        return res;
    }
};