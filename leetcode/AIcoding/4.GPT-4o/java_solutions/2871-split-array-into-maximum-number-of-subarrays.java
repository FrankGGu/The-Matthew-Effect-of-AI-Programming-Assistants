class Solution {
    public int maxSubarrays(int[] nums) {
        int currentGcd = nums[0], count = 0;
        for (int num : nums) {
            currentGcd = gcd(currentGcd, num);
            if (currentGcd == 1) {
                count++;
                currentGcd = nums[num];
            }
        }
        return count + (currentGcd == 1 ? 0 : 1);
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}