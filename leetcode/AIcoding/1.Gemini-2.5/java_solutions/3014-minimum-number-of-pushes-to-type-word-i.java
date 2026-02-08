import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int minimumPushes(String word) {
        int[] freq = new int[26];
        for (char c : word.toCharArray()) {
            freq[c - 'a']++;
        }

        List<Integer> frequencies = new ArrayList<>();
        for (int count : freq) {
            if (count > 0) {
                frequencies.add(count);
            }
        }

        Collections.sort(frequencies, Collections.reverseOrder());

        int totalPushes = 0;
        int pushMultiplier = 1;
        int charactersAssignedToCurrentMultiplier = 0;

        for (int i = 0; i < frequencies.size(); i++) {
            totalPushes += frequencies.get(i) * pushMultiplier;
            charactersAssignedToCurrentMultiplier++;

            if (charactersAssignedToCurrentMultiplier == 8) {
                pushMultiplier++;
                charactersAssignedToCurrentMultiplier = 0;
            }
        }

        return totalPushes;
    }
}