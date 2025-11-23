import java.util.Arrays;

class Solution {
    public int numRescueBoats(int[] people, int limit) {
        Arrays.sort(people);
        int boats = 0;
        int left = 0;
        int right = people.length - 1;

        while (left <= right) {
            boats++;
            if (people[left] + people[right] <= limit) {
                left++;
            }
            right--;
        }

        return boats;
    }
}