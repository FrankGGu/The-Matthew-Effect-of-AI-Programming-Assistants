#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int maxEqualFreq(vector<int>& nums) {
        map<int, int> count;
        map<int, int> freq;
        int maxFreq = 0;
        int result = 0;

        for (int i = 0; i < nums.size(); ++i) {
            int num = nums[i];
            if (count[num] > 0) {
                freq[count[num]]--;
                if (freq[count[num]] == 0) {
                    freq.erase(count[num]);
                }
            }
            count[num]++;
            freq[count[num]]++;
            maxFreq = max(maxFreq, count[num]);

            if (freq.size() == 1) {
                result = i + 1;
            } else if (freq.size() == 2) {
                if ((freq.begin()->first == 1 && freq.begin()->second == 1) || 
                    (next(freq.begin())->first == 1 && next(freq.begin())->second == 1)) {
                    result = i + 1;
                } else if (abs(freq.begin()->first - next(freq.begin())->first) == 1) {
                    result = i + 1;
                }
            }
        }

        return result;
    }
};