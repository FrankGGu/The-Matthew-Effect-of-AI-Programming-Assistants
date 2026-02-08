class Solution {
public:
    int maxChunksToSorted(vector<int>& arr) {
        int res = 0, max_val = 0;
        for (int i = 0; i < arr.size(); ++i) {
            max_val = max(max_val, arr[i]);
            if (max_val == i) {
                ++res;
            }
        }
        return res;
    }
};