#include <vector>
#include <stack>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> nextGreaterElement(vector<int>& nums1, vector<int>& nums2) {
        unordered_map<int, int> nextGreater;
        stack<int> s;
        vector<int> result(nums1.size(), -1);

        for (int num : nums2) {
            while (!s.empty() && num > s.top()) {
                nextGreater[s.top()] = num;
                s.pop();
            }
            s.push(num);
        }

        for (int i = 0; i < nums1.size(); ++i) {
            if (nextGreater.count(nums1[i])) {
                result[i] = nextGreater[nums1[i]];
            }
        }

        return result;
    }
};