class Solution {
    public long findTheArrayConcVal(int[] nums) {
        long concVal = 0;
        int left = 0;
        int right = nums.length - 1;

        while (left <= right) {
            if (left == right) {
                concVal += nums[left];
            } else {
                int first = nums[left];
                int last = nums[right];

                long powerOf10 = 1;
                int tempLast = last;

                // Calculate 10^(number of digits in last)
                // Special case for last = 0, it has 1 digit
                if (tempLast == 0) {
                    powerOf10 = 10;
                } else {
                    while (tempLast > 0) {
                        powerOf10 *= 10;
                        tempLast /= 10;
                    }
                }

                concVal += (long)first * powerOf10 + last;
            }
            left++;
            right--;
        }
        return concVal;
    }
}