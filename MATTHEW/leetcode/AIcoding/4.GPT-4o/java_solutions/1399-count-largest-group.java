class Solution {
    public int countLargestGroup(int n) {
        int[] count = new int[37];
        for (int i = 1; i <= n; i++) {
            int sum = 0, num = i;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            count[sum]++;
        }
        int maxCount = 0, groups = 0;
        for (int c : count) {
            if (c > maxCount) {
                maxCount = c;
                groups = 1;
            } else if (c == maxCount) {
                groups++;
            }
        }
        return groups;
    }
}