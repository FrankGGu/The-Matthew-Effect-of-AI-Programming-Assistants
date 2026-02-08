public class Solution {

import java.util.*;

public class Solution {
    public int minimumTeachPairs(String[] languages, int[][] pairs) {
        Map<Integer, Set<String>> personToLanguages = new HashMap<>();
        for (int i = 0; i < languages.length; i++) {
            String[] langList = languages[i].split(" ");
            Set<String> langs = new HashSet<>(Arrays.asList(langList));
            personToLanguages.put(i, langs);
        }

        Map<String, Set<Integer>> languageToPeople = new HashMap<>();
        for (int i = 0; i < languages.length; i++) {
            Set<String> langs = personToLanguages.get(i);
            for (String lang : langs) {
                languageToPeople.putIfAbsent(lang, new HashSet<>());
                languageToPeople.get(lang).add(i);
            }
        }

        Set<Integer> taught = new HashSet<>();
        int count = 0;

        for (int[] pair : pairs) {
            int a = pair[0] - 1;
            int b = pair[1] - 1;
            Set<String> langA = personToLanguages.get(a);
            Set<String> langB = personToLanguages.get(b);

            boolean hasCommon = false;
            for (String lang : langA) {
                if (langB.contains(lang)) {
                    hasCommon = true;
                    break;
                }
            }

            if (!hasCommon) {
                if (!taught.contains(a)) {
                    taught.add(a);
                    count++;
                }
                if (!taught.contains(b)) {
                    taught.add(b);
                    count++;
                }
            }
        }

        return count;
    }
}
}