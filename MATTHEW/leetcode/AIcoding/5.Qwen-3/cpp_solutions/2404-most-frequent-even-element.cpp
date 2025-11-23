#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mostFrequentEven(const vector<int>& nums) {
        unordered_map<int, int> freq;
        int maxFreq = 0;
        int result = -1;

        for (int num : nums) {
            if (num % 2 == 0) {
                freq[num]++;
                if (freq[num] > maxFreq || (freq[num] == maxFreq && num < result)) {
                    maxFreq = freq[num];
                    result = num;
                }
            }
        }

        return result;
    }
};