import java.util.HashMap;
import java.util.Map;
import java.util.Arrays;

class Solution {
    public boolean closeStrings(String word1, String word2) {
        if (word1.length() != word2.length()) return false;

        Map<Character, Integer> count1 = new HashMap<>();
        Map<Character, Integer> count2 = new HashMap<>();

        for (char c : word1.toCharArray()) {
            count1.put(c, count1.getOrDefault(c, 0) + 1);
        }

        for (char c : word2.toCharArray()) {
            count2.put(c, count2.getOrDefault(c, 0) + 1);
        }

        if (!count1.keySet().equals(count2.keySet())) return false;

        int[] freq1 = count1.values().stream().mapToInt(i -> i).toArray();
        int[] freq2 = count2.values().stream().mapToInt(i -> i).toArray();

        Arrays.sort(freq1);
        Arrays.sort(freq2);

        return Arrays.equals(freq1, freq2);
    }
}