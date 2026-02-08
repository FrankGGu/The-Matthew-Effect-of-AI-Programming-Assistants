import java.util.Arrays;
import java.util.Comparator;

class Solution {
    private static class Pair {
        int value;
        int originalIndex;

        Pair(int value, int originalIndex) {
            this.value = value;
            this.originalIndex = originalIndex;
        }
    }

    public int[] advantageShuffle(int[] nums1, int[] nums2) {
        int n = nums1.length;

        Arrays.sort(nums1);

        Pair[] nums2Pairs = new Pair[n];
        for (int i = 0; i < n; i++) {
            nums2Pairs[i] = new Pair(nums2[i], i);
        }

        Arrays.sort(nums2Pairs, Comparator.comparingInt(p -> p.value));

        int[] result = new int[n];

        int left1 = 0;
        int right1 = n - 1;

        int left2 = 0;
        int right2 = n - 1;

        while (left2 <= right2) {
            int currentNum2Value = nums2Pairs[left2].value;
            int originalNum2Index = nums2Pairs[left2].originalIndex;

            if (nums1[left1] > currentNum2Value) {
                result[originalNum2Index] = nums1[left1];
                left1++;
                left2++;
            } else {
                result[nums2Pairs[right2].originalIndex] = nums1[left1];
                left1++;
                right2--;
            }
        }

        return result;
    }
}