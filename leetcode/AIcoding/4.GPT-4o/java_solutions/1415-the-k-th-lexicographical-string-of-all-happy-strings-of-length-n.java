import java.util.ArrayList;
import java.util.List;

public class Solution {
    public String getHappyString(int n, int k) {
        List<String> happyStrings = new ArrayList<>();
        generateHappyStrings("", n, happyStrings);
        return k <= happyStrings.size() ? happyStrings.get(k - 1) : "";
    }

    private void generateHappyStrings(String current, int n, List<String> happyStrings) {
        if (current.length() == n) {
            happyStrings.add(current);
            return;
        }
        if (current.isEmpty() || current.charAt(current.length() - 1) != 'a') {
            generateHappyStrings(current + 'a', n, happyStrings);
        }
        if (current.isEmpty() || current.charAt(current.length() - 1) != 'b') {
            generateHappyStrings(current + 'b', n, happyStrings);
        }
        if (current.isEmpty() || current.charAt(current.length() - 1) != 'c') {
            generateHappyStrings(current + 'c', n, happyStrings);
        }
    }
}