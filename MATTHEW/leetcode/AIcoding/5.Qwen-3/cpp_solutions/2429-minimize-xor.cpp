#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeXOR(int nums, int k) {
        vector<int> bits;
        while (nums > 0) {
            bits.push_back(nums % 2);
            nums /= 2;
        }
        reverse(bits.begin(), bits.end());

        int n = bits.size();
        for (int i = 0; i < k; ++i) {
            bool found = false;
            for (int j = 0; j < n; ++j) {
                if (bits[j] == 1) {
                    bits[j] = 0;
                    for (int l = j + 1; l < n; ++l) {
                        bits[l] = 1;
                    }
                    found = true;
                    break;
                }
            }
            if (!found) {
                bits.push_back(1);
                for (int l = 1; l < n; ++l) {
                    bits[l] = 0;
                }
                break;
            }
        }

        int result = 0;
        for (int i = 0; i < bits.size(); ++i) {
            result = (result << 1) | bits[i];
        }
        return result;
    }
};