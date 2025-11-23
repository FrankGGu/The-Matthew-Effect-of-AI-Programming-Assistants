import java.util.HashSet;
import java.util.Set;

class Solution {
    public int maximumSetSize(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int halfN = n / 2;

        Set<Integer> set1 = new HashSet<>();
        for (int num : nums1) {
            set1.add(num);
        }

        Set<Integer> set2 = new HashSet<>();
        for (int num : nums2) {
            set2.add(num);
        }

        int distinctInSet1 = set1.size();
        int distinctInSet2 = set2.size();

        Set<Integer> commonElements = new HashSet<>(set1);
        commonElements.retainAll(set2);
        int commonCount = commonElements.size();

        int uniqueToSet1Count = distinctInSet1 - commonCount;
        int uniqueToSet2Count = distinctInSet2 - commonCount;

        int currentSetSize = 0;
        int remainingPicksFrom1 = halfN;
        int remainingPicksFrom2 = halfN;

        // Step 1: Pick unique elements from nums1 that are not in nums2
        int pickedFromUniqueTo1 = Math.min(uniqueToSet1Count, remainingPicksFrom1);
        currentSetSize += pickedFromUniqueTo1;
        remainingPicksFrom1 -= pickedFromUniqueTo1;

        // Step 2: Pick unique elements from nums2 that are not in nums1
        int pickedFromUniqueTo2 = Math.min(uniqueToSet2Count, remainingPicksFrom2);
        currentSetSize += pickedFromUniqueTo2;
        remainingPicksFrom2 -= pickedFromUniqueTo2;

        // Step 3: Use common elements to fill remaining slots
        // The number of common distinct elements we can add is limited by:
        // 1. The total number of common distinct elements available.
        // 2. The sum of remaining "distinct element slots" we can still fill from each array.
        // Each common element chosen from nums1 uses a slot from nums1.
        // Each common element chosen from nums2 uses a slot from nums2.
        // We can pick at most `remainingPicksFrom1` distinct common elements from `nums1`'s quota,
        // and at most `remainingPicksFrom2` distinct common elements from `nums2`'s quota.
        // The total distinct common elements we can add is limited by the total common elements available,
        // and the total "distinct slots" we can still fill, which is `remainingPicksFrom1 + remainingPicksFrom2`.
        int pickedFromCommon = Math.min(commonCount, remainingPicksFrom1 + remainingPicksFrom2);
        currentSetSize += pickedFromCommon;

        // The maximum size of the final set cannot exceed n (total elements picked).
        return Math.min(n, currentSetSize);
    }
}