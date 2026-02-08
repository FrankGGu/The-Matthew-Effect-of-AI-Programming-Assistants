import java.util.ArrayList;
import java.util.List;

public class CombinationIterator {
    private List<String> combinations;
    private int index;

    public CombinationIterator(String characters, int combinationLength) {
        combinations = new ArrayList<>();
        generateCombinations(characters, combinationLength, 0, "");
        index = 0;
    }

    private void generateCombinations(String characters, int combinationLength, int start, String current) {
        if (current.length() == combinationLength) {
            combinations.add(current);
            return;
        }
        for (int i = start; i < characters.length(); i++) {
            generateCombinations(characters, combinationLength, i + 1, current + characters.charAt(i));
        }
    }

    public String next() {
        return combinations.get(index++);
    }

    public boolean hasNext() {
        return index < combinations.size();
    }
}