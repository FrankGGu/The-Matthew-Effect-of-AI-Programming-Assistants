#include <vector>
#include <stack>
#include <algorithm> // Not strictly needed for this specific stack logic, but useful for general C++

class Solution {
public:
    std::vector<int> nextGreaterElement(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> ans(n, -1);

        // s1 stores indices of elements in decreasing order of their values.
        // These elements are candidates for finding their *first* next greater element.
        std::stack<int> s1; 

        // s2 stores indices of elements that have already found their *first* next greater element,
        // and are now waiting for their *second* next greater element.
        // s2 also maintains elements in decreasing order of their values.
        std::stack<int> s2; 

        for (int i = 0; i < n; ++i) {
            // Step 1: Process s2 for second next greater element
            // If nums[i] is greater than elements at the top of s2, then nums[i] is their second NGE.
            while (!s2.empty() && nums[s2.top()] < nums[i]) {
                ans[s2.top()] = nums[i];
                s2.pop();
            }

            // Step 2: Process s1 for first next greater element
            // Collect elements from s1 that find nums[i] as their first NGE.
            // These elements will then be moved to s2.
            std::vector<int> temp_s1_pops;
            while (!s1.empty() && nums[s1.top()] < nums[i]) {
                temp_s1_pops.push_back(s1.top());
                s1.pop();
            }

            // Step 3: Push elements from temp_s1_pops to s2
            // Elements in temp_s1_pops are in increasing order of their values (because they were popped from s1).
            // To maintain s2 as a decreasing stack, push them in reverse order.
            for (int j = temp_s1_pops.size() - 1; j >= 0; --j) {
                s2.push(temp_s1_pops[j]);
            }

            // Step 4: Push current index to s1
            // This maintains s1's decreasing property.
            s1.push(i);
        }

        return ans;
    }
};