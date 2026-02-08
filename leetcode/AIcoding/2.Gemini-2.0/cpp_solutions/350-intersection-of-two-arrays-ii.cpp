#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> intersect(vector<int>& nums1, vector<int>& nums2) {
        unordered_map<int, int> count1;
        for (int num : nums1) {
            count1[num]++;
        }

        vector<int> result;
        for (int num : nums2) {
            if (count1.count(num) && count1[num] > 0) {
                result.push_back(num);
                count1[num]--;
            }
        }

        return result;
    }
};