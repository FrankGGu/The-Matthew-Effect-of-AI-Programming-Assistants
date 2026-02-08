import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;

public class Solution {
    public List<String> distinctNames(String[] ideas) {
        HashSet<String> set = new HashSet<>();
        for (String idea : ideas) {
            set.add(idea);
        }

        long count = 0;
        List<String> result = new ArrayList<>();

        for (int i = 0; i < ideas.length; i++) {
            String idea1 = ideas[i];
            for (char c = 'a'; c <= 'z'; c++) {
                String newIdea = c + idea1.substring(1);
                if (!set.contains(newIdea)) {
                    count++;
                }
            }
            result.add(idea1 + " can form " + (26 - 1) + " valid names");
        }

        return result;
    }
}