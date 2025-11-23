import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int minimumPushes(String word) {
        int[] counts = new int[26];
        for (char c : word.toCharArray()) {
            counts[c - 'a']++;
        }

        List<Integer> frequencies = new ArrayList<>();
        for (int count : counts) {
            if (count > 0) {
                frequencies.add(count);
            }
        }

        Collections.sort(frequencies, Collections.reverseOrder());

        int totalPushes = 0;
        for (int i = 0; i < frequencies.size(); i++) {
            int multiplier = (i / 8) + 1;
            totalPushes += frequencies.get(i) * multiplier;
        }

        return totalPushes;
    }
}