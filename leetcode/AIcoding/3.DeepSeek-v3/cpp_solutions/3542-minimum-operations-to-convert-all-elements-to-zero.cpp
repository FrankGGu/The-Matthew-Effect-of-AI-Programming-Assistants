#include <vector>
#include <unordered_map>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            if (num > 0) {
                freq[num]++;
            }
        }
        return freq.size();
    }
};