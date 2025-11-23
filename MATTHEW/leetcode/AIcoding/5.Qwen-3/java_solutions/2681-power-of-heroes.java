public class Solution {

import java.util.*;

public class PowerOfHeroes {
    public int maxPower(List<String> words) {
        int max = 0;
        for (int i = 0; i < words.size(); i++) {
            int count = 1;
            for (int j = i + 1; j < words.size(); j++) {
                if (words.get(j).equals(words.get(j - 1))) {
                    count++;
                } else {
                    break;
                }
            }
            max = Math.max(max, count);
        }
        return max;
    }
}
}