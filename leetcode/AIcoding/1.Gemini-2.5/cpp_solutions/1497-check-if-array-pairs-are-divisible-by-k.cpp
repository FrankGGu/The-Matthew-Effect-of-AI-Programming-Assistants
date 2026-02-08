#include <vector>
#include <numeric>

class Solution {
public:
    bool canArrange(std::vector<int>& arr, int k) {
        std::vector<int> freq(k, 0);

        for (int num : arr) {
            freq[(num % k + k) % k]++;
        }

        if (freq[0] % 2 != 0) {
            return false;
        }

        for (int r = 1; r <= k / 2; ++r) {
            if (r == k - r) { 
                if (freq[r] % 2 != 0) {
                    return false;
                }
            } else { 
                if (freq[r] != freq[k - r]) {
                    return false;
                }
            }
        }

        return true;
    }
};