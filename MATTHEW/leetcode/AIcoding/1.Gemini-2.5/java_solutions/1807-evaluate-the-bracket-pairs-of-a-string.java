import java.util.List;
import java.util.Map;
import java.util.HashMap;

class Solution {
    public String evaluate(String s, List<List<String>> knowledge) {
        Map<String, String> knowledgeMap = new HashMap<>();
        for (List<String> entry : knowledge) {
            knowledgeMap.put(entry.get(0), entry.get(1));
        }

        StringBuilder result = new StringBuilder();
        StringBuilder currentKey = new StringBuilder();
        boolean inBracket = false;

        for (char c : s.toCharArray()) {
            if (c == '(') {
                inBracket = true;
                currentKey.setLength(0); // Clear for new key
            } else if (c == ')') {
                inBracket = false;
                String key = currentKey.toString();
                result.append(knowledgeMap.getOrDefault(key, "?"));
            } else {
                if (inBracket) {
                    currentKey.append(c);
                } else {
                    result.append(c);
                }
            }
        }

        return result.toString();
    }
}