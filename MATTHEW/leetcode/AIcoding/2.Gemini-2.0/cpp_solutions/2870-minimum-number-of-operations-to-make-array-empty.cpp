#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        int operations = 0;
        for (auto const& [num, count] : counts) {
            if (count == 1) {
                return -1;
            }

            operations += (count + 2) / 3;
        }

        return operations;
    }
};