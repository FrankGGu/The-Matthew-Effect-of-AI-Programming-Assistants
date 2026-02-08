import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

class Solution {
    public List<String> splitWordsBySeparator(List<String> words, String separator) {
        List<String> result = new ArrayList<>();

        StringBuilder regexBuilder = new StringBuilder();
        for (int i = 0; i < separator.length(); i++) {
            if (i > 0) {
                regexBuilder.append("|");
            }
            regexBuilder.append(Pattern.quote(String.valueOf(separator.charAt(i))));
        }
        String regex = regexBuilder.toString();

        for (String word : words) {
            String[] parts = word.split(regex);
            for (String part : parts) {
                if (!part.isEmpty()) {
                    result.add(part);
                }
            }
        }

        return result;
    }
}