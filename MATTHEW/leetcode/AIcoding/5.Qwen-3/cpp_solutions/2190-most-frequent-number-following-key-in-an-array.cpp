#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int mostFrequent(vector<int>& nums, int key) {
        unordered_map<int, int> freq;
        int maxFreq = 0;
        int result = -1;

        for (int i = 0; i < nums.size() - 1; ++i) {
            if (nums[i] == key) {
                int nextNum = nums[i + 1];
                freq[nextNum]++;
                if (freq[nextNum] > maxFreq || (freq[nextNum] == maxFreq && nextNum < result)) {
                    maxFreq = freq[nextNum];
                    result = nextNum;
                }
            }
        }

        return result;
    }
};