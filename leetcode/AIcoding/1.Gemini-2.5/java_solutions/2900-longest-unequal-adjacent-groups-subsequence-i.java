import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> getLongestSubsequence(List<String> words, List<Integer> groups) {
        List<String> result = new ArrayList<>();
        int lastGroup = -1; // Initialize with a value that won't match any valid group ID

        for (int i = 0; i < words.size(); i++) {
            if (groups.get(i) != lastGroup) {
                result.add(words.get(i));
                lastGroup = groups.get(i);
            }
        }

        return result;
    }
}