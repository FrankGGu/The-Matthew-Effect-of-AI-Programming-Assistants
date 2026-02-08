#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> frequencySort(vector<int>& nums) {
        map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        sort(nums.begin(), nums.end(), [&](int a, int b) {
            if (freq[a] != freq[b]) {
                return freq[a] < freq[b];
            }
            return a > b;
        });

        return nums;
    }
};