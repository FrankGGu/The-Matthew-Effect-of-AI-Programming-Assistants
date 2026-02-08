public class Solution {

import java.util.ArrayList;
import java.util.List;

public class CombinationIterator {
    private List<String> combinations;
    private int index;

    public CombinationIterator(String characters, int combinationLength) {
        combinations = new ArrayList<>();
        generateCombinations(characters, combinationLength, 0, new StringBuilder(), combinations);
        index = 0;
    }

    private void generateCombinations(String characters, int length, int start, StringBuilder current, List<String> result) {
        if (current.length() == length) {
            result.add(current.toString());
            return;
        }
        for (int i = start; i < characters.length(); i++) {
            current.append(characters.charAt(i));
            generateCombinations(characters, length, i + 1, current, result);
            current.deleteCharAt(current.length() - 1);
        }
    }

    public String next() {
        return combinations.get(index++);
    }

    public boolean hasNext() {
        return index < combinations.size();
    }
}
}