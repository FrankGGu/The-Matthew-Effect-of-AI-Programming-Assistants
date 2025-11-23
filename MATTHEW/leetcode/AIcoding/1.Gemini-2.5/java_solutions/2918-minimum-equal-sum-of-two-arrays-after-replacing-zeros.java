class Solution {
    public long minSum(int[] nums1, int[] nums2) {
        long sum1 = 0;
        int zeros1 = 0;
        for (int num : nums1) {
            if (num == 0) {
                zeros1++;
            } else {
                sum1 += num;
            }
        }

        long sum2 = 0;
        int zeros2 = 0;
        for (int num : nums2) {
            if (num == 0) {
                zeros2++;
            } else {
                sum2 += num;
            }
        }

        long minPossibleSum1;
        if (zeros1 == 0) {
            minPossibleSum1 = sum1;
        } else {
            minPossibleSum1 = sum1 + zeros1;
        }

        long minPossibleSum2;
        if (zeros2 == 0) {
            minPossibleSum2 = sum2;
        } else {
            minPossibleSum2 = sum2 + zeros2;
        }

        if (zeros1 == 0 && zeros2 == 0) {
            if (sum1 == sum2) {
                return sum1;
            } else {
                return -1;
            }
        } else if (zeros1 == 0) {
            if (sum1 < minPossibleSum2) {
                return -1;
            } else {
                return sum1;
            }
        } else if (zeros2 == 0) {
            if (sum2 < minPossibleSum1) {
                return -1;
            } else {
                return sum2;
            }
        } else {
            return Math.max(minPossibleSum1, minPossibleSum2);
        }
    }
}