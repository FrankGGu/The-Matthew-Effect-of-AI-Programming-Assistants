class Solution {
    public int subarrayGCD(int[] nums, int k) {
        int n = nums.length;
        int count = 0;

        for (int i = 0; i < n; i++) {
            int currentGcd = 0; 
            for (int j = i; j < n; j++) {
                if (nums[j] % k != 0) {
                    break; 
                }

                currentGcd = gcd(currentGcd, nums[j]);

                if (currentGcd == k) {
                    count++;
                }

                if (currentGcd < k) {
                    break; 
                }
            }
        }

        return count;
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