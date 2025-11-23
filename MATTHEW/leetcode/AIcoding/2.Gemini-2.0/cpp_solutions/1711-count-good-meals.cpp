#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countGoodMeals(vector<int>& deliciousness) {
        unordered_map<int, int> count;
        long long res = 0;
        int mod = 1e9 + 7;
        for (int d : deliciousness) {
            for (int i = 0; i < 22; ++i) {
                int powerOfTwo = 1 << i;
                if (count.count(powerOfTwo - d)) {
                    res = (res + count[powerOfTwo - d]) % mod;
                }
            }
            count[d]++;
        }
        return (int)res;
    }
};