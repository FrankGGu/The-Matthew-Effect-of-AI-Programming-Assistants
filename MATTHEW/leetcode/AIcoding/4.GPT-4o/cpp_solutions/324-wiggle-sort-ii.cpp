class Solution {
public:
    void wiggleSort(vector<int>& nums) {
        int n = nums.size();
        vector<int> temp = nums;
        sort(temp.begin(), temp.end());

        int mid = (n - 1) / 2;
        int j = mid;
        int k = n - 1;

        for (int i = 0; i < n; i++) {
            nums[i] = (i % 2 == 0) ? temp[j--] : temp[k--];
        }
    }
};