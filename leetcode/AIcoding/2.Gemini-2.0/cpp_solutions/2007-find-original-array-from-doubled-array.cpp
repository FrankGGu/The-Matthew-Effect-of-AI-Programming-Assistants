#include <vector>
#include <algorithm>
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

        vector<int> original;
        for (auto& [num, freq] : count) {
            if (freq > 0) {
                if (count.find(2 * num) == count.end() || count[2 * num] < freq) {
                    if (num == 0 && freq % 2 == 0) {
                        for (int i = 0; i < freq / 2; ++i) {
                            original.push_back(0);
                        }
                        count[num] = 0;
                    }
                    else if (num != 0)
                        return {};
                    else
                        return {};
                }
                else {
                    for (int i = 0; i < freq; ++i) {
                        original.push_back(num);
                    }
                    count[2 * num] -= freq;
                    count[num] = 0;
                }
            }
        }

        if (original.size() == changed.size() / 2) {
            return original;
        } else {
            return {};
        }
    }
};