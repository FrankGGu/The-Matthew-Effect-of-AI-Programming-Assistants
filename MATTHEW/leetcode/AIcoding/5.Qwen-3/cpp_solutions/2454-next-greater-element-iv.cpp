#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> nextGreaterElement(vector<int>& nums1, vector<int>& nums2) {
        vector<int> result(nums1.size(), -1);
        stack<int> s;
        unordered_map<int, int> map;

        for (int i = 0; i < nums2.size(); ++i) {
            while (!s.empty() && nums2[i] > s.top()) {
                map[s.top()] = nums2[i];
                s.pop();
            }
            s.push(nums2[i]);
        }

        for (int i = 0; i < nums1.size(); ++i) {
            if (map.find(nums1[i]) != map.end()) {
                result[i] = map[nums1[i]];
            }
        }

        return result;
    }
};