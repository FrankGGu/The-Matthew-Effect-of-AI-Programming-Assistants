import java.util.Arrays;

class Solution {
    public int numFriendRequests(int[] ages) {
        Arrays.sort(ages);
        int count = 0;
        for (int i = 0; i < ages.length; i++) {
            int age = ages[i];
            int lowerBound = (int) (age * 0.5 + 7);
            int left = 0;
            int right = ages.length - 1;
            int lowerIndex = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (ages[mid] > lowerBound) {
                    lowerIndex = mid;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }

            left = 0;
            right = ages.length - 1;
            int upperIndex = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (ages[mid] <= age) {
                    upperIndex = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            if (lowerIndex != -1 && upperIndex != -1 && lowerIndex <= upperIndex) {
                count += (upperIndex - lowerIndex + 1);
                if (ages[i] == age) {
                    count--;
                }
            }
        }
        return count;
    }
}