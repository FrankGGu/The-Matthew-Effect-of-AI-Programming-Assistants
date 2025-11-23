#include <iostream>
#include <vector>
#include <unordered_map>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> nextGreaterElement(vector<int>& nums1, vector<int>& nums2) {
        unordered_map<int, int> next_greater;
        stack<int> s;

        for (int num : nums2) {
            while (!s.empty() && num > s.top()) {
                next_greater[s.top()] = num;
                s.pop();
            }
            s.push(num);
        }

        vector<int> result;
        for (int num : nums1) {
            result.push_back(next_greater.count(num) ? next_greater[num] : -1);
        }

        return result;
    }
};