public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> findAnagrams(String s, String p) {
        int[] count = new int[26];
        int lenP = p.length();
        int lenS = s.length();
        List<Integer> result = new ArrayList<>();

        if (lenP > lenS) {
            return result;
        }

        for (int i = 0; i < lenP; i++) {
            count[p.charAt(i) - 'a']++;
        }

        int left = 0;
        for (int right = 0; right < lenS; right++) {
            count[s.charAt(right) - 'a']--;

            while (count[s.charAt(right) - 'a'] < 0) {
                count[s.charAt(left) - 'a']++;
                left++;
            }

            if (right - left + 1 == lenP) {
                result.add(left);
            }
        }

        return result;
    }
}
}