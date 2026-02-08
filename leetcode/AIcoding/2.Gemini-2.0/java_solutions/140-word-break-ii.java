import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Solution {
    public List<String> wordBreak(String s, List<String> wordDict) {
        Set<String> wordSet = new HashSet<>(wordDict);
        return wordBreakHelper(s, wordSet, new ArrayList<>(), new ArrayList<>());
    }

    private List<String> wordBreakHelper(String s, Set<String> wordSet, List<String> current, List<String> result) {
        if (s.isEmpty()) {
            result.add(String.join(" ", current));
            return result;
        }

        for (int i = 1; i <= s.length(); i++) {
            String prefix = s.substring(0, i);
            if (wordSet.contains(prefix)) {
                current.add(prefix);
                wordBreakHelper(s.substring(i), wordSet, current, result);
                current.remove(current.size() - 1);
            }
        }

        return result;
    }
}