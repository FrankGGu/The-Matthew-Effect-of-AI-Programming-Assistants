class Solution {
    public int countLargestGroup(int n) {
        int[] groupCounts = new int[37]; // Max digit sum for n=9999 is 36 (9+9+9+9)

        for (int i = 1; i <= n; i++) {
            int sum = 0;
            int temp = i;
            while (temp > 0) {
                sum += temp % 10;
                temp /= 10;
            }
            groupCounts[sum]++;
        }

        int maxGroupSize = 0;
        for (int count : groupCounts) {
            if (count > maxGroupSize) {
                maxGroupSize = count;
            }
        }

        int numberOfLargestGroups = 0;
        for (int count : groupCounts) {
            if (count == maxGroupSize) {
                numberOfLargestGroups++;
            }
        }

        return numberOfLargestGroups;
    }
}