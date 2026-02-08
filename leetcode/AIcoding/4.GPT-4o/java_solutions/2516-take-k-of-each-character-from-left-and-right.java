import java.util.HashMap;
import java.util.Map;

class Solution {
    public String takeCharacters(String s, int k) {
        Map<Character, Integer> count = new HashMap<>();
        int n = s.length();
        int left = 0, right = 0, maxLength = 0;

        while (right < n) {
            count.put(s.charAt(right), count.getOrDefault(s.charAt(right), 0) + 1);
            while (count.size() > k) {
                count.put(s.charAt(left), count.get(s.charAt(left)) - 1);
                if (count.get(s.charAt(left)) == 0) {
                    count.remove(s.charAt(left));
                }
                left++;
            }
            maxLength = Math.max(maxLength, right - left + 1);
            right++;
        }

        return s.substring(0, maxLength);
    }
}