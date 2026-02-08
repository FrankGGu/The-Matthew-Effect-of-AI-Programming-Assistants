#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    long long wonderfulSubstrings(string word) {
        vector<long long> count(1024, 0);
        count[0] = 1;
        long long ans = 0;
        int mask = 0;
        for (char c : word) {
            mask ^= (1 << (c - 'a'));
            ans += count[mask];
            for (int i = 0; i < 10; ++i) {
                ans += count[mask ^ (1 << i)];
            }
            count[mask]++;
        }
        return ans;
    }
};