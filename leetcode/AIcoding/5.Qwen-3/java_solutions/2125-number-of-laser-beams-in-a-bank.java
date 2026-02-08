public class Solution {

import java.util.*;

public class Solution {
    public int numberOfLaserBeams(String[] bank) {
        List<Integer> counts = new ArrayList<>();
        for (String row : bank) {
            int count = 0;
            for (char c : row.toCharArray()) {
                if (c == '1') {
                    count++;
                }
            }
            if (count > 0) {
                counts.add(count);
            }
        }
        int result = 0;
        for (int i = 0; i < counts.size() - 1; i++) {
            result += counts.get(i) * counts.get(i + 1);
        }
        return result;
    }
}
}