#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumSetSize(int n, vector<int>& nums1, vector<int>& nums2) {
        unordered_map<int, int> count1;
        unordered_map<int, int> count2;
        for (int num : nums1) {
            count1[num]++;
        }
        for (int num : nums2) {
            count2[num]++;
        }

        int common = 0;
        for (auto& [num, _] : count1) {
            if (count2.find(num) != count2.end()) {
                common++;
            }
        }

        int totalUnique = count1.size() + count2.size() - common;
        int maxPossible = min(n, totalUnique);
        return maxPossible;
    }
};