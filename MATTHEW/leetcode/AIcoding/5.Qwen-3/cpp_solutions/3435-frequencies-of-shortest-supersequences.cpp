#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int findMinCount(vector<int>& nums1, vector<int>& nums2) {
        unordered_map<int, int> freq1;
        for (int num : nums1) {
            freq1[num]++;
        }

        unordered_map<int, int> freq2;
        for (int num : nums2) {
            freq2[num]++;
        }

        int count = 0;
        for (auto& [num, freq] : freq1) {
            if (freq2.find(num) != freq2.end()) {
                count += max(freq, freq2[num]);
            } else {
                count += freq;
            }
        }

        for (auto& [num, freq] : freq2) {
            if (freq1.find(num) == freq1.end()) {
                count += freq;
            }
        }

        return count;
    }
};