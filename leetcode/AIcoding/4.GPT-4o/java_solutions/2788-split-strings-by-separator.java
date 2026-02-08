import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> splitString(String s, char separator) {
        List<String> result = new ArrayList<>();
        String[] parts = s.split(String.valueOf(separator));
        for (String part : parts) {
            if (!part.isEmpty()) {
                result.add(part);
            }
        }
        return result;
    }
}