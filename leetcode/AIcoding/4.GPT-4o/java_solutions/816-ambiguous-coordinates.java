import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> ambiguousCoordinates(String s) {
        s = s.substring(1, s.length() - 1);
        List<String> result = new ArrayList<>();
        int n = s.length();
        for (int i = 1; i < n; i++) {
            String left = s.substring(0, i);
            String right = s.substring(i);
            List<String> leftCoords = generateCoordinates(left);
            List<String> rightCoords = generateCoordinates(right);
            for (String l : leftCoords) {
                for (String r : rightCoords) {
                    result.add("(" + l + ", " + r + ")");
                }
            }
        }
        return result;
    }

    private List<String> generateCoordinates(String s) {
        List<String> coords = new ArrayList<>();
        int n = s.length();
        if (n == 1 || (s.charAt(0) != '0')) {
            coords.add(s);
        }
        for (int i = 1; i < n; i++) {
            String integerPart = s.substring(0, i);
            String fractionalPart = s.substring(i);
            if (fractionalPart.length() > 0 && (fractionalPart.charAt(0) != '0')) {
                coords.add(integerPart + "." + fractionalPart);
            }
            if (fractionalPart.length() == 0 || (fractionalPart.length() == 1 && fractionalPart.charAt(0) == '0')) {
                coords.add(integerPart);
            }
        }
        return coords;
    }
}