class Solution {
public:
    int maxHeight(int A, int B, int C) {
        int heights[3] = {A, B, C};
        sort(heights, heights + 3);
        return heights[0] + heights[1] + heights[2];
    }
};