import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> findInvalidIPAddresses(String s) {
        List<String> result = new ArrayList<>();
        int n = s.length();
        for (int i = 1; i < 4 && i < n; i++) {
            for (int j = i + 1; j < i + 4 && j < n; j++) {
                for (int k = j + 1; k < j + 4 && k < n; k++) {
                    String part1 = s.substring(0, i);
                    String part2 = s.substring(i, j);
                    String part3 = s.substring(j, k);
                    String part4 = s.substring(k);
                    if (isValid(part1) && isValid(part2) && isValid(part3) && isValid(part4)) {
                        result.add(part1 + "." + part2 + "." + part3 + "." + part4);
                    }
                }
            }
        }
        return result;
    }

    private boolean isValid(String s) {
        if (s.length() > 1 && s.charAt(0) == '0') {
            return false;
        }
        int num = Integer.parseInt(s);
        return num >= 0 && num <= 255;
    }
}