import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> lastVisitedIntegers(List<String> words) {
        List<Integer> visitedNumbers = new ArrayList<>();
        List<Integer> result = new ArrayList<>();
        int prevCount = 0;

        for (String word : words) {
            if (word.equals("prev")) {
                prevCount++;
                if (prevCount <= visitedNumbers.size()) {
                    result.add(visitedNumbers.get(visitedNumbers.size() - prevCount));
                } else {
                    result.add(-1);
                }
            } else {
                visitedNumbers.add(Integer.parseInt(word));
                prevCount = 0;
            }
        }

        return result;
    }
}