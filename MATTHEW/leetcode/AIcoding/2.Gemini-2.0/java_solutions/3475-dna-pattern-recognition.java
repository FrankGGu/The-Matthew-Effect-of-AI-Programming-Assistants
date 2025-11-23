import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<String> findRepeatedDnaSequences(String s, int k) {
        if (s == null || s.length() <= k) {
            return new ArrayList<>();
        }

        Map<String, Integer> sequenceCount = new HashMap<>();
        List<String> result = new ArrayList<>();

        for (int i = 0; i <= s.length() - k; i++) {
            String sequence = s.substring(i, i + k);
            sequenceCount.put(sequence, sequenceCount.getOrDefault(sequence, 0) + 1);
        }

        for (Map.Entry<String, Integer> entry : sequenceCount.entrySet()) {
            if (entry.getValue() > 1) {
                result.add(entry.getKey());
            }
        }

        return result;
    }

    public List<String> findRepeatedDnaSequences(String s) {
        return findRepeatedDnaSequences(s, 10);
    }
}