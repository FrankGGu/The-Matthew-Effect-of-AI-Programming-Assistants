class Solution {
public:
    int maxSubarrays(vector<int>& nums) {
        int n = nums.size();
        int ans = 1;
        int curr = nums[0];
        for (int i = 1; i < n; ++i) {
            curr &= nums[i];
        }
        if (curr != 0) {
            return 1;
        }

        curr = nums[0];
        for (int i = 1; i < n; ++i) {
            curr &= nums[i];
            if (curr == 0) {
                ans++;
                if (i + 1 < n) {
                    curr = nums[i + 1];
                    i++;
                     while(i < n && curr == 0) {
                        i++;
                        if(i < n)
                            curr = nums[i];
                     }
                    i--;
                }
            }
        }
        curr = nums[0];
        int count = 0;
        for(int i = 0; i < n; i++){
            curr &= nums[i];
            if(curr == 0){
                count++;
                if(i+1 < n)
                    curr = nums[i+1];
            }
        }

        curr = nums[0];
        ans = 0;
        for (int i = 0; i < n; ++i) {
            curr &= nums[i];
            if (curr == 0) {
                ans++;
                if (i + 1 < n) {
                    curr = nums[i + 1];
                }
            }
        }

        return ans;
    }
};