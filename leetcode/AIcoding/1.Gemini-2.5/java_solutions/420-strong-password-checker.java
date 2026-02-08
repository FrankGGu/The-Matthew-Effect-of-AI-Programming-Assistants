import java.util.ArrayList;
import java.util.List;

class Solution {
    public int strongPasswordChecker(String s) {
        int n = s.length();

        // 1. Check for missing character types
        boolean hasLower = false;
        boolean hasUpper = false;
        boolean hasDigit = false;
        for (char c : s.toCharArray()) {
            if (Character.isLowerCase(c)) {
                hasLower = true;
            } else if (Character.isUpperCase(c)) {
                hasUpper = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            }
        }
        int missingTypes = (hasLower ? 0 : 1) + (hasUpper ? 0 : 1) + (hasDigit ? 0 : 1);

        // 2. Find repeating sequences
        // Store the lengths of consecutive repeating character groups of length >= 3.
        List<Integer> repeats = new ArrayList<>();
        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && s.charAt(j) == s.charAt(i)) {
                j++;
            }
            int length = j - i;
            if (length >= 3) {
                repeats.add(length);
            }
            i = j;
        }

        // Calculate total replacements needed for repeats if no deletions/insertions
        int totalReplacementsForRepeats = 0;
        for (int len : repeats) {
            totalReplacementsForRepeats += len / 3;
        }

        // Case 1: n < 6 (Too short)
        if (n < 6) {
            // We need 6 - n insertions.
            // These insertions can also fix missing types.
            // The number of operations is the maximum of insertions needed and missing types.
            // For n < 6, any repeating characters are implicitly handled by these operations.
            return Math.max(6 - n, missingTypes);
        }

        // Case 2: 6 <= n <= 20 (Ideal length)
        if (n <= 20) {
            // No length adjustments needed.
            // Operations are replacements. Each replacement can fix a missing type OR break a repeat group.
            return Math.max(missingTypes, totalReplacementsForRepeats);
        }

        // Case 3: n > 20 (Too long)
        // We need n - 20 deletions.
        // Deletions reduce the length, and can also help break repeating sequences.
        // Deletions DO NOT help with missingTypes.
        int deletionsNeeded = n - 20;
        int ans = deletionsNeeded; // Initial cost from deletions

        // Now we have 'deletionsNeeded' operations that are deletions.
        // We need to satisfy 'missingTypes' and fix 'repeats'.
        // We use deletions to reduce 'totalReplacementsForRepeats'.

        // Store counts of groups by their modulo 3 remainder
        int[] modCounts = new int[3]; // modCounts[0] for k%3==0, modCounts[1] for k%3==1, modCounts[2] for k%3==2
        for (int len : repeats) {
            modCounts[len % 3]++;
        }

        // Phase 1: Use deletions on groups where k % 3 == 0 (e.g., "aaa", "aaaaaa").
        // Each deletion from such a group reduces `totalReplacementsForRepeats` by 1.
        // Example: "aaa" (k=3, k%3=0, needs 1 replacement). Delete 1 char -> "aa" (k=2, needs 0 replacements).
        int canDeleteFromMod0 = Math.min(deletionsNeeded, modCounts[0]);
        deletionsNeeded -= canDeleteFromMod0;
        totalReplacementsForRepeats -= canDeleteFromMod0;

        // Phase 2: Use deletions on groups where k % 3 == 1 (e.g., "aaaa", "aaaaaaa").
        // Each 2 deletions from such a group reduces `totalReplacementsForRepeats` by 1.
        // Example: "aaaa" (k=4, k%3=1, needs 1 replacement). Delete 2 chars -> "aa" (k=2, needs 0 replacements).
        int canDeleteFromMod1 = Math.min(deletionsNeeded / 2, modCounts[1]);
        deletionsNeeded -= canDeleteFromMod1 * 2;
        totalReplacementsForRepeats -= canDeleteFromMod1;

        // Phase 3: Use remaining deletions on any group.
        // Each 3 deletions reduces `totalReplacementsForRepeats` by 1.
        // This covers k%3==2 groups and any remaining from k%3==0 or k%3==1 groups.
        totalReplacementsForRepeats -= deletionsNeeded / 3;

        // The remaining operations are replacements.
        // These replacements need to cover 'missingTypes' and the 'totalReplacementsForRepeats' that couldn't be fixed by deletions.
        // Since one replacement can fix either a missing type or break a repeat, we take the maximum of the two needs.
        ans += Math.max(missingTypes, totalReplacementsForRepeats);

        return ans;
    }
}