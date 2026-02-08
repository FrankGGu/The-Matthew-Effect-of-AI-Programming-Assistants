#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numTriplets(vector<int>& nums1, vector<int>& nums2) {
        unordered_map<int, int> count1;
        unordered_map<int, int> count2;

        for (int num : nums1) {
            count1[num]++;
        }

        for (int num : nums2) {
            count2[num]++;
        }

        int result = 0;

        for (auto& [num, freq] : count1) {
            int square = num * num;
            result += freq * count2[square];
        }

        for (auto& [num, freq] : count2) {
            int square = num * num;
            result += freq * count1[square];
        }

        return result;
    }
};