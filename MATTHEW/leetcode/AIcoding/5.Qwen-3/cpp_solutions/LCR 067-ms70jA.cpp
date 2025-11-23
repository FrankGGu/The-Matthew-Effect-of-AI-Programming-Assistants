#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int findMaximumXOR(vector<int>& nums) {
        int max_xor = 0;
        int mask = 0;

        for (int i = 31; i >= 0; --i) {
            mask = mask | (1 << i);
            vector<int> prefixes;
            for (int num : nums) {
                prefixes.push_back(num & mask);
            }

            int tmp = max_xor | (1 << i);
            bool found = false;
            for (int prefix : prefixes) {
                if (find(prefixes.begin(), prefixes.end(), prefix ^ tmp) != prefixes.end()) {
                    found = true;
                    break;
                }
            }

            if (found) {
                max_xor = tmp;
            }
        }

        return max_xor;
    }
};