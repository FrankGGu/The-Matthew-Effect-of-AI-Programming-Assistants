#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findSmallestMissing(vector<int>& nums, int value) {
        unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num % value]++;
        }

        int missing = 0;
        while (true) {
            int remainder = missing % value;
            if (counts[remainder] == 0) {
                return missing;
            } else {
                counts[remainder]--;
                missing++;
            }
        }
    }
};