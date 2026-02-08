import java.util.Arrays;

class Solution {
    public int maxStrength(int[] nums) {
        Arrays.sort(nums);
        long product = 1;
        int negativeCount = 0;
        int firstNegativeIndex = -1;

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] < 0) {
                negativeCount++;
                if (firstNegativeIndex == -1) {
                    firstNegativeIndex = i;
                }
            }
        }

        if (nums.length == 1) {
            return nums[0];
        }

        if (negativeCount == 0) {
            boolean hasZero = false;
            for (int num : nums) {
                if (num == 0) {
                    hasZero = true;
                    break;
                }
            }
            if (hasZero) {
                return 0;
            } else {
                for (int num : nums) {
                    product *= num;
                }
                return (int)product;
            }

        }

        if (negativeCount % 2 == 0) {
            for (int num : nums) {
                if (num != 0) {
                    product *= num;
                }
            }
        } else {
            boolean hasZero = false;
            for (int num : nums) {
                if (num == 0) {
                    hasZero = true;
                    break;
                }
            }

            if (negativeCount == 1 && hasZero && nums.length > 1) {
                return 0;
            }

            if(nums.length == negativeCount && hasZero){
                return 0;
            }

            if(nums.length == negativeCount && !hasZero){
                for(int i = 1; i < nums.length; i++){
                    product *= nums[i];
                }
            } else {
                for (int num : nums) {
                    if (num != nums[firstNegativeIndex] && num != 0) {
                        product *= num;
                    }
                }
                if (product == 1 && nums[firstNegativeIndex] < 0) {
                    boolean positiveFound = false;
                    for(int num : nums){
                        if(num > 0){
                            positiveFound = true;
                            break;
                        }
                    }

                    if(positiveFound){
                         for (int num : nums) {
                             if (num != nums[firstNegativeIndex] && num != 0) {
                                 product *= num;
                             }
                         }
                    } else {
                        for(int i = 1; i < nums.length; i++){
                            product *= nums[i];
                        }
                    }
                }
            }
        }
        return (int) product;
    }
}