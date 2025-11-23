#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    bool isPossible(vector<int>& nums) {
        unordered_map<int, int> freq, appendFreq;
        for (int num : nums) {
            freq[num]++;
        }
        for (int num : nums) {
            if (freq[num] == 0) continue;
            if (appendFreq[num] > 0) {
                appendFreq[num]--;
                appendFreq[num + 1]++;
            } else if (freq[num + 1] > 0 && freq[num + 2] > 0) {
                freq[num + 1]--;
                freq[num + 2]--;
                appendFreq[num + 3]++;
            } else {
                return false;
            }
            freq[num]--;
        }
        return true;
    }
};