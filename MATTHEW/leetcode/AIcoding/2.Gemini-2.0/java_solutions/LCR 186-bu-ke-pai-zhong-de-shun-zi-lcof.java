import java.util.*;

class Solution {
    public String solve(String[] dynasty, String[] era, String artifact) {
        Map<String, String> dynastyToEra = new HashMap<>();
        for (int i = 0; i < dynasty.length; i++) {
            dynastyToEra.put(dynasty[i], era[i]);
        }

        for (String d : dynasty) {
            if (artifact.contains(d)) {
                return dynastyToEra.get(d);
            }
        }

        return "Unknown";
    }
}