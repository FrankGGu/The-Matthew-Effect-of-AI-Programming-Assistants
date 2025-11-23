#include <vector>
#include <unordered_map>

class Solution {
public:
    bool canArrange(std::vector<int>& arr, int k) {
        std::unordered_map<int, int> remainderCount;
        for (int num : arr) {
            int rem = ((num % k) + k) % k;
            remainderCount[rem]++;
        }
        for (int i = 1; i < k; i++) {
            if (remainderCount[i] != remainderCount[k - i]) {
                return false;
            }
        }
        return remainderCount[0] % 2 == 0;
    }
};