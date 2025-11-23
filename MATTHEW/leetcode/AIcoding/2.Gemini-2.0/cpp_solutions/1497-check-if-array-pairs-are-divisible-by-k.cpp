#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool canArrange(vector<int>& arr, int k) {
        unordered_map<int, int> remainderCounts;
        for (int num : arr) {
            int remainder = (num % k + k) % k;
            remainderCounts[remainder]++;
        }

        for (int i = 1; i <= k / 2; ++i) {
            if (remainderCounts[i] != remainderCounts[k - i]) {
                return false;
            }
        }

        if (remainderCounts[0] % 2 != 0) {
            return false;
        }

        if (k % 2 == 0 && remainderCounts[k / 2] % 2 != 0) {
            return false;
        }

        return true;
    }
};