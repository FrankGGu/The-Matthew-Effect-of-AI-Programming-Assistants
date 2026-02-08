class Solution {
    public long minimumCost(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int median = nums[n / 2];
        long minCost = Long.MAX_VALUE;

        for (int candidate : new int[]{getNextPalindrome(median, false), getNextPalindrome(median, true)}) {
            long cost = 0;
            for (int num : nums) {
                cost += Math.abs(num - candidate);
            }
            if (cost < minCost) {
                minCost = cost;
            }
        }

        return minCost;
    }

    private int getNextPalindrome(int num, boolean smaller) {
        int candidate = num;
        while (true) {
            if (isPalindrome(candidate)) {
                return candidate;
            }
            if (smaller) {
                candidate--;
                if (candidate < 0) {
                    break;
                }
            } else {
                candidate++;
            }
        }
        return -1;
    }

    private boolean isPalindrome(int num) {
        if (num < 0) {
            return false;
        }
        String s = Integer.toString(num);
        int left = 0, right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}