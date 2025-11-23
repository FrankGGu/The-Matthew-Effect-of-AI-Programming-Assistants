import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int numberOfWeakCharacters(int[][] properties) {
        // Sort the characters. The primary sort key is 'attack' in descending order.
        // The secondary sort key (for ties in 'attack') is 'defense' in ascending order.
        //
        // Rationale for sorting:
        // When iterating through the sorted array, if we encounter a character `C = [attack_C, defense_C]`,
        // all characters `P = [attack_P, defense_P]` processed *before* `C` will satisfy:
        // 1. `attack_P > attack_C` (due to primary descending sort)
        // OR
        // 2. `attack_P == attack_C` AND `defense_P <= defense_C` (due to secondary ascending sort for ties)
        //
        // If `attack_P > attack_C`:
        // These `P` characters are potential candidates to make `C` weak.
        // If `defense_C < maxDefense` (where `maxDefense` is the maximum defense encountered from such `P` characters),
        // then `C` is weak.
        //
        // If `attack_P == attack_C`:
        // These `P` characters cannot make `C` weak, because their attack is not strictly greater.
        // Due to `defense_P <= defense_C` from the tie-breaking rule, `defense_P` will not cause
        // `maxDefense` to be updated to a value that would falsely mark `C` as weak.
        // Specifically, if `maxDefense` was updated by `defense_P` (where `attack_P == attack_C`),
        // then `defense_P` must be greater than the previous `maxDefense`.
        // However, since `defense_P <= defense_C`, `defense_C < defense_P` would be false,
        // preventing `C` from being marked weak by `P`.
        // This ensures `maxDefense` effectively only reflects the maximum defense of characters
        // that have a strictly greater attack than the current character being considered.
        Arrays.sort(properties, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                if (a[0] != b[0]) {
                    return b[0] - a[0]; // Sort by attack descending
                } else {
                    return a[1] - b[1]; // Sort by defense ascending for ties
                }
            }
        });

        int weakCharactersCount = 0;
        int maxDefenseSoFar = 0; // Stores the maximum defense encountered among characters processed so far

        for (int[] property : properties) {
            int currentDefense = property[1];

            // If the current character's defense is less than the maximum defense encountered so far,
            // it means there exists at least one character (processed earlier due to sorting)
            // with strictly greater attack AND strictly greater defense.
            // Thus, the current character is weak.
            if (currentDefense < maxDefenseSoFar) {
                weakCharactersCount++;
            } else {
                // Update maxDefenseSoFar. This character might be a stronger character
                // for subsequent characters to compare against.
                maxDefenseSoFar = Math.max(maxDefenseSoFar, currentDefense);
            }
        }

        return weakCharactersCount;
    }
}