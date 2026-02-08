import java.util.Stack;

class Solution {
    public boolean isValid(String code) {
        if (code.isEmpty()) {
            return false;
        }

        Stack<String> tagStack = new Stack<>();
        int i = 0;
        boolean hasOutermostTag = false;

        while (i < code.length()) {
            if (i + 8 < code.length() && code.substring(i, i + 9).equals("<![CDATA[")) {
                if (tagStack.isEmpty()) {
                    return false;
                }
                int cdataEnd = code.indexOf("]]>", i);
                if (cdataEnd == -1) {
                    return false;
                }
                i = cdataEnd + 3;
            } else if (i + 1 < code.length() && code.substring(i, i + 2).equals("</")) {
                int tagEnd = code.indexOf('>', i);
                if (tagEnd == -1) {
                    return false;
                }
                String tagName = code.substring(i + 2, tagEnd);
                if (!isValidTagName(tagName)) {
                    return false;
                }
                if (tagStack.isEmpty() || !tagStack.pop().equals(tagName)) {
                    return false;
                }
                i = tagEnd + 1;

                if (tagStack.isEmpty() && i != code.length()) {
                    return false;
                }
            } else if (code.charAt(i) == '<') {
                int tagEnd = code.indexOf('>', i);
                if (tagEnd == -1) {
                    return false;
                }
                String tagName = code.substring(i + 1, tagEnd);
                if (!isValidTagName(tagName)) {
                    return false;
                }

                if (!hasOutermostTag && i != 0) {
                    return false;
                }
                hasOutermostTag = true;
                tagStack.push(tagName);
                i = tagEnd + 1;
            } else {
                if (tagStack.isEmpty()) {
                    return false;
                }
                i++;
            }
        }

        return tagStack.isEmpty() && hasOutermostTag;
    }

    private boolean isValidTagName(String tagName) {
        if (tagName.isEmpty() || tagName.length() > 9) {
            return false;
        }
        for (char c : tagName.toCharArray()) {
            if (!Character.isUpperCase(c)) {
                return false;
            }
        }
        return true;
    }
}