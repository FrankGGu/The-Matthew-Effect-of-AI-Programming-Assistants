import java.util.ArrayList;
import java.util.List;

class Solution {
    public String[] divideString(String s, int k, char fill) {
        List<String> result = new ArrayList<>();
        int n = s.length();

        for (int i = 0; i < n; i += k) {
            StringBuilder currentGroup = new StringBuilder();
            int end = Math.min(i + k, n);
            currentGroup.append(s.substring(i, end));

            while (currentGroup.length() < k) {
                currentGroup.append(fill);
            }
            result.add(currentGroup.toString());
        }

        return result.toArray(new String[0]);
    }
}