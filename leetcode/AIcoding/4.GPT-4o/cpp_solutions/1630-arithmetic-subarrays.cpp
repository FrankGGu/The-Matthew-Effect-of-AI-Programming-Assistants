class Solution {
public:
    vector<bool> checkArithmeticSubarrays(vector<int>& nums, vector<int>& l, vector<int>& r) {
        int m = l.size();
        vector<bool> result(m);

        for (int i = 0; i < m; ++i) {
            int start = l[i], end = r[i];
            if (end - start < 2) {
                result[i] = true;
                continue;
            }

            vector<int> subarray(nums.begin() + start, nums.begin() + end + 1);
            sort(subarray.begin(), subarray.end());
            int diff = subarray[1] - subarray[0];
            result[i] = true;

            for (int j = 2; j < subarray.size(); ++j) {
                if (subarray[j] - subarray[j - 1] != diff) {
                    result[i] = false;
                    break;
                }
            }
        }

        return result;
    }
};