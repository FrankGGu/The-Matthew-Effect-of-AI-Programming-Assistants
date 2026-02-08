import java.util.*;

class Solution {

    // Helper method to generate all possible subset sums for a given array segment
    private void generateSubsetSums(int index, long currentSum, int[] arr, List<Long> sumsList) {
        // Base case: if we have processed all elements in the current segment
        if (index == arr.length) {
            sumsList.add(currentSum);
            return;
        }

        // Recursive call: Include the current element
        generateSubsetSums(index + 1, currentSum + arr[index], arr, sumsList);

        // Recursive call: Exclude the current element
        generateSubsetSums(index + 1, currentSum, arr, sumsList);
    }

    public long minimumDamage(int[] damage, long health) {
        long totalSum = 0;
        for (int d : damage) {
            totalSum += d;
        }

        // If the total damage from all attacks is less than Bob's health, it's impossible.
        if (totalSum < health) {
            return -1;
        }

        // We want to find a subset sum S such that S >= health and S is minimized.
        // This is equivalent to finding a subset sum S_remove such that
        // S_remove <= totalSum - health and S_remove is maximized.
        // The answer will then be totalSum - S_remove.
        long targetToRemove = totalSum - health;

        long maxSremove = 0; // Stores the maximum S_remove found

        int n = damage.length;
        int mid = n / 2;

        // Split the damage array into two halves
        int[] leftHalf = new int[mid];
        int[] rightHalf = new int[n - mid];

        for (int i = 0; i < mid; i++) {
            leftHalf[i] = damage[i];
        }
        for (int i = 0; i < n - mid; i++) {
            rightHalf[i] = damage[mid + i];
        }

        // Generate all subset sums for the left half
        List<Long> sumsLeft = new ArrayList<>();
        generateSubsetSums(0, 0L, leftHalf, sumsLeft);

        // Generate all subset sums for the right half
        List<Long> sumsRight = new ArrayList<>();
        generateSubsetSums(0, 0L, rightHalf, sumsRight);

        // Sort sumsRight to enable efficient binary search
        Collections.sort(sumsRight);

        // Remove duplicate sums from sumsRight to optimize binary search and memory.
        // This is crucial if the number of distinct sums is much smaller than 2^(N/2).
        List<Long> distinctSumsRight = new ArrayList<>();
        if (!sumsRight.isEmpty()) {
            distinctSumsRight.add(sumsRight.get(0));
            for (int i = 1; i < sumsRight.size(); i++) {
                if (!sumsRight.get(i).equals(sumsRight.get(i - 1))) {
                    distinctSumsRight.add(sumsRight.get(i));
                }
            }
        }
        sumsRight = distinctSumsRight; // Use the list with distinct sums

        // Iterate through sums from the left half
        for (long s1 : sumsLeft) {
            // If s1 alone already exceeds targetToRemove, it cannot be part of maxSremove
            if (s1 > targetToRemove) {
                continue;
            }

            // We need to find s2 from sumsRight such that s1 + s2 <= targetToRemove
            // and s1 + s2 is maximized. This means s2 should be as large as possible
            // but not exceeding (targetToRemove - s1).
            long neededS2 = targetToRemove - s1;

            // Use binary search to find the largest s2 in sumsRight that is <= neededS2
            int idx = Collections.binarySearch(sumsRight, neededS2);

            if (idx < 0) {
                // If neededS2 is not found, binarySearch returns -(insertion_point) - 1.
                // The insertion_point is the index of the first element greater than neededS2.
                // So, the largest element less than or equal to neededS2 would be at (insertion_point - 1).
                idx = -idx - 1; 
                idx--; // Move to the element just before the insertion point
            }
            // If idx >= 0, neededS2 was found. Collections.binarySearch returns an index of an occurrence.
            // Since we want the largest s2 <= neededS2, and the list is sorted,
            // if neededS2 itself is present, using that index is correct.
            // If there are multiple occurrences of neededS2, any index will work for maximizing s1+s2.

            // If a valid s2 is found (i.e., idx is a valid index in sumsRight)
            if (idx >= 0 && idx < sumsRight.size()) {
                maxSremove = Math.max(maxSremove, s1 + sumsRight.get(idx));
            }
        }

        // The minimum total damage dealt is totalSum - maxSremove
        return totalSum - maxSremove;
    }
}