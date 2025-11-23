import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Solution {
    public int minimumTeachings(int n, List<List<Integer>> languages, List<List<Integer>> friendships) {
        Set<Integer> peopleToTeach = new HashSet<>();
        Set<Integer> peopleWithLanguage = new HashSet<>();

        for (List<Integer> friendship : friendships) {
            int personA = friendship.get(0);
            int personB = friendship.get(1);
            boolean knowsLanguageA = false;
            boolean knowsLanguageB = false;

            for (int langA : languages.get(personA - 1)) {
                if (peopleWithLanguage.contains(langA)) {
                    knowsLanguageA = true;
                    break;
                }
            }
            for (int langB : languages.get(personB - 1)) {
                if (peopleWithLanguage.contains(langB)) {
                    knowsLanguageB = true;
                    break;
                }
            }

            if (!knowsLanguageA) {
                peopleToTeach.add(personA);
            }
            if (!knowsLanguageB) {
                peopleToTeach.add(personB);
            }
        }

        return peopleToTeach.size();
    }
}