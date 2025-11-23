import java.util.HashMap;
import java.util.Map;

class Solution {
    public int findTheLongestSubstring(String s) {
        int maxLen = 0;
        int mask = 0; // Represents the parity of vowel counts
        // bit 0 for 'a', bit 1 for 'e', bit 2 for 'i', bit 3 for 'o', bit 4 for 'u'

        // Map to store the first occurrence of each mask
        // Key: mask value, Value: index where this mask was first encountered
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, -1); // Initialize with mask 0 at index -1 to handle substrings starting from index 0

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);

            // Update the mask based on the current character
            switch (c) {
                case 'a':
                    mask ^= (1 << 0);
                    break;
                case 'e':
                    mask ^= (1 << 1);
                    break;
                case 'i':
                    mask ^= (1 << 2);
                    break;
                case 'o':
                    mask ^= (1 << 3);
                    break;
                case 'u':
                    mask ^= (1 << 4);
                    break;
            }

            // If this mask has been seen before
            if (map.containsKey(mask)) {
                // The substring from map.get(mask) + 1 to i has even counts for all vowels
                maxLen = Math.max(maxLen, i - map.get(mask));
            } else {
                // If this is the first time we see this mask, store its index
                map.put(mask, i);
            }
        }

        return maxLen;
    }
}