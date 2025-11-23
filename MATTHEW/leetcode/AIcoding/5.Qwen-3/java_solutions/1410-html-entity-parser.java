public class Solution {
    public String entityParser(String text) {
        StringBuilder result = new StringBuilder();
        int i = 0;
        while (i < text.length()) {
            if (text.charAt(i) == '&') {
                int j = i + 1;
                while (j < text.length() && text.charAt(j) != ';') {
                    j++;
                }
                if (j < text.length()) {
                    String entity = text.substring(i, j + 1);
                    switch (entity) {
                        case "&quot;":
                            result.append('"');
                            break;
                        case "&apos;":
                            result.append('\'');
                            break;
                        case "&amp;":
                            result.append('&');
                            break;
                        case "&lt;":
                            result.append('<');
                            break;
                        case "&gt;":
                            result.append('>');
                            break;
                        case "&frasl;":
                            result.append('/');
                            break;
                        default:
                            result.append(entity);
                            break;
                    }
                    i = j + 1;
                } else {
                    result.append(text.charAt(i));
                    i++;
                }
            } else {
                result.append(text.charAt(i));
                i++;
            }
        }
        return result.toString();
    }
}