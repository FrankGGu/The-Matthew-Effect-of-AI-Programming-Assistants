class Solution {
    private long calculateSum(int[] arr, int value) {
        long currentSum = 0;
        for (int x : arr) {
            currentSum += Math.min(x, value);
        }
        return currentSum;
    }

    public int findBestValue(int[] arr, int target) {
        int low = 0;
        int high = 100000; 

        int ans_v1 = high + 1; 

        while (low <= high) {
            int mid = low + (high - low) / 2;
            long currentSum = calculateSum(arr, mid);

            if (currentSum >= target) {
                ans_v1 = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        if (ans_v1 == 0) {
            return 0;
        }

        if (ans_v1 == 100001) {
            return 100000;
        }

        long sum1 = calculateSum(arr, ans_v1);
        long diff1 = Math.abs(sum1 - target);

        long sum2 = calculateSum(arr, ans_v1 - 1);
        long diff2 = Math.abs(sum2 - target);

        if (diff1 < diff2) {
            return ans_v1;
        } else if (diff2 < diff1) {
            return ans_v1 - 1;
        } else { 
            return ans_v1 - 1;
        }
    }
}