import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Solution {
    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> result = new ArrayList<>();
        if (s.length() < p.length()) return result;

        HashMap<Character, Integer> pCount = new HashMap<>();
        HashMap<Character, Integer> sCount = new HashMap<>();

        for (char c : p.toCharArray()) {
            pCount.put(c, pCount.getOrDefault(c, 0) + 1);
        }

        for (int i = 0; i < p.length(); i++) {
            sCount.put(s.charAt(i), sCount.getOrDefault(s.charAt(i), 0) + 1);
        }

        if (sCount.equals(pCount)) {
            result.add(0);
        }

        for (int i = p.length(); i < s.length(); i++) {
            sCount.put(s.charAt(i), sCount.getOrDefault(s.charAt(i), 0) + 1);
            sCount.put(s.charAt(i - p.length()), sCount.get(s.charAt(i - p.length())) - 1);
            if (sCount.get(s.charAt(i - p.length())) == 0) {
                sCount.remove(s.charAt(i - p.length()));
            }

            if (sCount.equals(pCount)) {
                result.add(i - p.length() + 1);
            }
        }

        return result;
    }
}