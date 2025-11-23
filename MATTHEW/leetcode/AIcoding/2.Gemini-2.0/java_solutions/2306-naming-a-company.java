import java.util.*;

class Solution {
    public long distinctNames(String[] ideas) {
        Set<String>[] groups = new HashSet[26];
        for (int i = 0; i < 26; i++) {
            groups[i] = new HashSet<>();
        }

        for (String idea : ideas) {
            groups[idea.charAt(0) - 'a'].add(idea.substring(1));
        }

        long result = 0;
        for (int i = 0; i < 26; i++) {
            for (int j = i + 1; j < 26; j++) {
                long common = 0;
                for (String ideaA : groups[i]) {
                    if (groups[j].contains(ideaA)) {
                        common++;
                    }
                }
                result += 2 * (groups[i].size() - common) * (groups[j].size() - common);
            }
        }

        return result;
    }
}