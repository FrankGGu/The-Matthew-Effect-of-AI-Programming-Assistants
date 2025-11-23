class Solution {
public:
    int getMaxLen(vector<int>& nums) {
        int maxLength = 0, currentLength = 0, negativeCount = 0;

        for (int num : nums) {
            if (num > 0) {
                currentLength++;
            } else if (num < 0) {
                negativeCount++;
                currentLength++;
            } else {
                currentLength = 0;
                negativeCount = 0;
            }

            if (negativeCount % 2 == 0) {
                maxLength = max(maxLength, currentLength);
            } else {
                int tempLength = currentLength;
                for (int i = nums.size() - 1; i >= 0; i--) {
                    if (nums[i] == 0) break;
                    tempLength--;
                    if (tempLength < 0) break;
                    maxLength = max(maxLength, tempLength);
                }
            }
        }

        return maxLength;
    }
};