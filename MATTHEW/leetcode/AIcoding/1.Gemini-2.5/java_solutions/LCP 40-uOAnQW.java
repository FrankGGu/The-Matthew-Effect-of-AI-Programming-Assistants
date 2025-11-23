import java.util.Arrays;
import java.util.Collections;

class Solution {
    public int mentalCalculation(int[] nums, int k) {
        if (k == 0) {
            return 0;
        }

        Integer[] numsObj = new Integer[nums.length];
        for (int i = 0; i < nums.length; i++) {
            numsObj[i] = nums[i];
        }
        Arrays.sort(numsObj, Collections.reverseOrder());

        long currentSum = 0;
        int selectedOddMin = -1;
        int selectedEvenMin = -1;

        for (int i = 0; i < k; i++) {
            currentSum += numsObj[i];
            if (numsObj[i] % 2 != 0) {
                if (selectedOddMin == -1 || numsObj[i] < selectedOddMin) {
                    selectedOddMin = numsObj[i];
                }
            } else {
                if (selectedEvenMin == -1 || numsObj[i] < selectedEvenMin) {
                    selectedEvenMin = numsObj[i];
                }
            }
        }

        if (currentSum % 2 == 0) {
            return (int) currentSum;
        }

        int unselectedEvenMax = -1;
        int unselectedOddMax = -1;

        for (int i = k; i < numsObj.length; i++) {
            if (numsObj[i] % 2 != 0) {
                if (unselectedOddMax == -1 || numsObj[i] > unselectedOddMax) {
                    unselectedOddMax = numsObj[i];
                }
            } else {
                if (unselectedEvenMax == -1 || numsObj[i] > unselectedEvenMax) {
                    unselectedEvenMax = numsObj[i];
                }
            }
        }

        long ans = -1;

        if (selectedOddMin != -1 && unselectedEvenMax != -1) {
            ans = Math.max(ans, currentSum - selectedOddMin + unselectedEvenMax);
        }

        if (selectedEvenMin != -1 && unselectedOddMax != -1) {
            ans = Math.max(ans, currentSum - selectedEvenMin + unselectedOddMax);
        }

        return (int) ans;
    }
}