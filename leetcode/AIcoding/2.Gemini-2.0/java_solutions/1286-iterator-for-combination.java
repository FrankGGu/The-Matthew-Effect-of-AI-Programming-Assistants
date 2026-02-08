import java.util.ArrayList;
import java.util.List;

class CombinationIterator {

    private List<String> combinations;
    private int currentIndex;

    public CombinationIterator(String characters, int combinationLength) {
        combinations = new ArrayList<>();
        generateCombinations(characters, combinationLength, 0, "", combinations);
        currentIndex = 0;
    }

    private void generateCombinations(String characters, int length, int index, String current, List<String> combinations) {
        if (length == 0) {
            combinations.add(current);
            return;
        }

        if (index == characters.length()) {
            return;
        }

        generateCombinations(characters, length - 1, index + 1, current + characters.charAt(index), combinations);
        generateCombinations(characters, length, index + 1, current, combinations);
    }

    public String next() {
        return combinations.get(currentIndex++);
    }

    public boolean hasNext() {
        return currentIndex < combinations.size();
    }
}