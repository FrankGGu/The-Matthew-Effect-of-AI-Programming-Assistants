import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> removeComments(String[] source) {
        List<String> result = new ArrayList<>();
        boolean inBlock = false;
        StringBuilder sb = new StringBuilder();

        for (String line : source) {
            for (int i = 0; i < line.length(); i++) {
                if (inBlock) {
                    if (line.charAt(i) == '*' && i + 1 < line.length() && line.charAt(i + 1) == '/') {
                        inBlock = false;
                        i++;
                    }
                } else {
                    if (line.charAt(i) == '/' && i + 1 < line.length() && line.charAt(i + 1) == '/') {
                        break;
                    } else if (line.charAt(i) == '/' && i + 1 < line.length() && line.charAt(i + 1) == '*') {
                        inBlock = true;
                        i++;
                    } else {
                        sb.append(line.charAt(i));
                    }
                }
            }
            if (!inBlock && sb.length() > 0) {
                result.add(sb.toString());
                sb = new StringBuilder();
            }
        }

        return result;
    }
}