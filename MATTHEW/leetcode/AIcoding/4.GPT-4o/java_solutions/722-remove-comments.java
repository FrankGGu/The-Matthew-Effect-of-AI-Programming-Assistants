import java.util.*;

public class Solution {
    public List<String> removeComments(String[] source) {
        List<String> result = new ArrayList<>();
        StringBuilder currentLine = new StringBuilder();
        boolean inBlockComment = false;

        for (String line : source) {
            for (int i = 0; i < line.length(); i++) {
                if (inBlockComment) {
                    if (i + 1 < line.length() && line.charAt(i) == '*' && line.charAt(i + 1) == '/') {
                        inBlockComment = false;
                        i++;
                    }
                } else {
                    if (i + 1 < line.length() && line.charAt(i) == '/' && line.charAt(i + 1) == '*') {
                        inBlockComment = true;
                        i++;
                    } else if (i + 1 < line.length() && line.charAt(i) == '/' && line.charAt(i + 1) == '/') {
                        break;
                    } else {
                        currentLine.append(line.charAt(i));
                    }
                }
            }
            if (!inBlockComment && currentLine.length() > 0) {
                result.add(currentLine.toString());
                currentLine.setLength(0);
            }
        }

        return result;
    }
}