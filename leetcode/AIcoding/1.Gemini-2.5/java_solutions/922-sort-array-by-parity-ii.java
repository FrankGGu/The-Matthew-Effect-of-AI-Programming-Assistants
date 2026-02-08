class Solution {
    public int[] sortArrayByParityII(int[] nums) {
        int n = nums.length;
        int evenPtr = 0;
        int oddPtr = 1;

        while (evenPtr < n && oddPtr < n) {
            while (evenPtr < n && nums[evenPtr] % 2 == 0) {
                evenPtr += 2;
            }

            while (oddPtr < n && nums[oddPtr] % 2 == 1) {
                oddPtr += 2;
            }

            if (evenPtr < n && oddPtr < n) {
                int temp = nums[evenPtr];
                nums[evenPtr] = nums[oddPtr];
                nums[oddPtr] = temp;

                evenPtr += 2;
                oddPtr += 2;
            }
        }

        return nums;
    }
}