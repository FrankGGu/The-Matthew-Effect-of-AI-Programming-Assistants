import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;

class Solution {
    public List<String> removeAnagrams(String[] words) {
        List<String> result = new ArrayList<>();
        if (words == null || words.length == 0) {
            return result;
        }

        result.add(words[0]);
        String prev = sortString(words[0]);

        for (int i = 1; i < words.length; i++) {
            String curr = sortString(words[i]);
            if (!curr.equals(prev)) {
                result.add(words[i]);
                prev = curr;
            }
        }

        return result;
    }

    private String sortString(String s) {
        char[] arr = s.toCharArray();
        Arrays.sort(arr);
        return new String(arr);
    }
}