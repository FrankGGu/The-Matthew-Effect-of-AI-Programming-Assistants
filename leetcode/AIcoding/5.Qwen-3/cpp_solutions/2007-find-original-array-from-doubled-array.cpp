#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> findOriginalArray(vector<int>& changed) {
        if (changed.size() % 2 != 0) {
            return {};
        }

        map<int, int> count;
        for (int num : changed) {
            count[num]++;
        }

        vector<int> result;
        for (auto& [num, freq] : count) {
            if (freq == 0) continue;
            if (num == 0) {
                if (freq % 2 != 0) {
                    return {};
                }
                result.insert(result.end(), freq / 2, 0);
                count[num] = 0;
            } else {
                if (count.find(2 * num) == count.end()) {
                    return {};
                }
                if (count[2 * num] < freq) {
                    return {};
                }
                result.insert(result.end(), freq, num);
                count[2 * num] -= freq;
                count[num] = 0;
            }
        }

        return result;
    }
};