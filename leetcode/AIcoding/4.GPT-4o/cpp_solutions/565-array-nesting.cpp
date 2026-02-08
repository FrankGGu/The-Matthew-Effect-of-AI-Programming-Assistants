class Solution {
public:
    int arrayNesting(vector<int>& nums) {
        vector<bool> visited(nums.size(), false);
        int maxSize = 0;

        for (int i = 0; i < nums.size(); ++i) {
            if (!visited[i]) {
                int size = 0;
                int current = i;
                while (!visited[current]) {
                    visited[current] = true;
                    current = nums[current];
                    ++size;
                }
                maxSize = max(maxSize, size);
            }
        }

        return maxSize;
    }
};