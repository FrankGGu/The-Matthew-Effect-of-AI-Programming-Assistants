#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumMultiplicationScore(vector<int>& nums1, vector<int>& nums2) {
        int score = 0;
        for (int i = 0; i < nums1.size(); ++i) {
            score += nums1[i] * nums2[i];
        }
        return score;
    }
};