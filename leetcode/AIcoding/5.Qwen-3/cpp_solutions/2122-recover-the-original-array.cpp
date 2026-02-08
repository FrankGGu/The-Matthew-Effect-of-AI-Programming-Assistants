#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> recoverTheOriginalArray(vector<int>& s, int k) {
        map<int, int> count;
        for (int num : s) {
            count[num]++;
        }

        vector<int> result;
        for (auto& [num, freq] : count) {
            if (freq == 0) continue;
            if (num - k >= 0 && count[num - k] > 0) {
                int minFreq = min(freq, count[num - k]);
                for (int i = 0; i < minFreq; ++i) {
                    result.push_back(num - k);
                    result.push_back(num);
                }
                count[num - k] -= minFreq;
                count[num] -= minFreq;
            } else if (num - k < 0) {
                return {};
            }
        }

        return result;
    }
};