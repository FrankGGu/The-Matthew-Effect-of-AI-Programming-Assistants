class Solution {
public:
    int numberOfPoints(vector<vector<int>>& nums) {
        vector<bool> covered(101, false);
        for (const auto& interval : nums) {
            int start = interval[0];
            int end = interval[1];
            for (int i = start; i <= end; ++i) {
                covered[i] = true;
            }
        }
        int count = 0;
        for (bool isCovered : covered) {
            if (isCovered) {
                count++;
            }
        }
        return count;
    }
};