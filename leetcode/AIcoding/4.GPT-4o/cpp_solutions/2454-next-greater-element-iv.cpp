class Solution {
public:
    vector<int> nextGreater(vector<int>& nums1, vector<int>& nums2) {
        unordered_map<int, int> nextGreaterMap;
        stack<int> s;

        for (int num : nums2) {
            while (!s.empty() && s.top() < num) {
                nextGreaterMap[s.top()] = num;
                s.pop();
            }
            s.push(num);
        }

        vector<int> result;
        for (int num : nums1) {
            result.push_back(nextGreaterMap.count(num) ? nextGreaterMap[num] : -1);
        }

        return result;
    }
};