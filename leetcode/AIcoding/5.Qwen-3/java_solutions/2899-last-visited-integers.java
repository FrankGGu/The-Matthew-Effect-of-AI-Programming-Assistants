public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> getLastVisitedIntegers(List<String> words) {
        List<Integer> result = new ArrayList<>();
        List<String> temp = new ArrayList<>();

        for (String word : words) {
            if (word.matches("\\d+")) {
                temp.add(word);
            } else {
                result.addAll(temp);
                temp.clear();
            }
        }

        result.addAll(temp);

        Collections.reverse(result);
        return result;
    }
}
}