#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int maxDistinctElements(vector<int>& nums) {
        map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int distinct = 0;
        for (auto& [num, count] : freq) {
            if (count >= 2) {
                distinct++;
                count--;
                if (count >= 2) {
                    distinct++;
                }
            } else {
                distinct++;
            }
        }

        return distinct;
    }
};