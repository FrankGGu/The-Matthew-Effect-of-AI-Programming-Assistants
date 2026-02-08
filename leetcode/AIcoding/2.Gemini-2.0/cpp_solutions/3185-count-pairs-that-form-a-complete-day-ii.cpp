#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long countPairs(vector<int>& deliciousness) {
        long long count = 0;
        unordered_map<int, int> freq;
        for (int d : deliciousness) {
            for (int i = 0; i <= 21; ++i) {
                int powerOfTwo = 1 << i;
                if (powerOfTwo >= d && freq.count(powerOfTwo - d)) {
                    count = (count + freq[powerOfTwo - d]) % 1000000007;
                }
            }
            freq[d]++;
        }
        return count;
    }
};