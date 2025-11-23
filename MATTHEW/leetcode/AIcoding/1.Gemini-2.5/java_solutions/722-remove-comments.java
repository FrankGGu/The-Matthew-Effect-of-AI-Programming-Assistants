import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> removeComments(String[] source) {
        List<String> result = new ArrayList<>();
        StringBuilder currentLineBuilder = new StringBuilder();
        boolean inBlockComment = false;

        for (String line : source) {
            int i = 0;
            while (i < line.length()) {
                if (inBlockComment) {
                    // Look for end of block comment "*/"
                    if (i + 1 < line.length() && line.charAt(i) == '*' && line.charAt(i + 1) == '/') {
                        inBlockComment = false;
                        i += 2; // Skip "*/"
                    } else {
                        i++; // Still inside block comment, skip current char
                    }
                } else {
                    // Not in block comment, look for start of comments "//" or "/*"
                    if (i + 1 < line.length() && line.charAt(i) == '/' && line.charAt(i + 1) == '/') {
                        // Found line comment "//", rest of the line is ignored
                        break; // Move to the next source line
                    } else if (i + 1 < line.length() && line.charAt(i) == '/' && line.charAt(i + 1) == '*') {
                        // Found block comment "/*"
                        inBlockComment = true;
                        i += 2; // Skip "/*"
                    } else {
                        // Regular code character
                        currentLineBuilder.append(line.charAt(i));
                        i++;
                    }
                }
            }

            // After processing a source line
            // If we are not in a block comment and the current logical line has content, add it to result
            if (!inBlockComment && currentLineBuilder.length() > 0) {
                result.add(currentLineBuilder.toString());
                currentLineBuilder.setLength(0); // Reset for the next logical line
            }
            // If inBlockComment is true, currentLineBuilder content carries over to the next source line
            // If inBlockComment is false and currentLineBuilder is empty, do nothing (empty line after processing)
        }

        return result;
    }
}