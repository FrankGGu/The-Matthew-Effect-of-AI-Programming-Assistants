class Solution {
    public int minOperations(List<Integer> nums, int target) {
        long sum = 0;
        int[] count = new int[32];
        for (int num : nums) {
            sum += num;
            int power = (int) (Math.log(num) / Math.log(2));
            count[power]++;
        }
        if (sum < target) {
            return -1;
        }
        int operations = 0;
        for (int i = 0; i < 31; i++) {
            int bit = (target >> i) & 1;
            if (bit == 1) {
                if (count[i] > 0) {
                    count[i]--;
                } else {
                    int j = i + 1;
                    while (j < 31 && count[j] == 0) {
                        j++;
                    }
                    if (j == 31) {
                        return -1;
                    }
                    count[j]--;
                    for (int k = i; k < j; k++) {
                        count[k]++;
                    }
                    operations += j - i;
                }
            }
            count[i + 1] += count[i] / 2;
        }
        return operations;
    }
}