public class Solution {

import java.util.*;

public class Solution {
    public String tagValidator(String s) {
        Stack<String> stack = new Stack<>();
        int i = 0;
        while (i < s.length()) {
            if (s.charAt(i) == '<') {
                if (i + 1 < s.length() && s.charAt(i + 1) == '/') {
                    i += 2;
                    StringBuilder tag = new StringBuilder();
                    while (i < s.length() && s.charAt(i) != '>') {
                        if (Character.isLetter(s.charAt(i))) {
                            tag.append(s.charAt(i));
                            i++;
                        } else {
                            return "Invalid";
                        }
                    }
                    if (i >= s.length() || s.charAt(i) != '>') {
                        return "Invalid";
                    }
                    if (stack.isEmpty() || !stack.peek().equals(tag.toString())) {
                        return "Invalid";
                    }
                    stack.pop();
                    i++;
                } else if (i + 1 < s.length() && s.charAt(i + 1) != '!') {
                    i += 1;
                    StringBuilder tag = new StringBuilder();
                    while (i < s.length() && s.charAt(i) != '>') {
                        if (Character.isLetter(s.charAt(i))) {
                            tag.append(s.charAt(i));
                            i++;
                        } else {
                            return "Invalid";
                        }
                    }
                    if (i >= s.length() || s.charAt(i) != '>') {
                        return "Invalid";
                    }
                    stack.push(tag.toString());
                    i++;
                } else {
                    i += 1;
                    if (i + 2 < s.length() && s.charAt(i) == '!' && s.charAt(i + 1) == '[' && s.charAt(i + 2) == 'C' && s.charAt(i + 3) == 'D' && s.charAt(i + 4) == 'A' && s.charAt(i + 5) == 'T' && s.charAt(i + 6) == 'A' && s.charAt(i + 7) == '[') {
                        i += 8;
                        while (i < s.length() && !(s.charAt(i) == ']' && i + 1 < s.length() && s.charAt(i + 1) == ']')) {
                            i++;
                        }
                        if (i + 1 >= s.length() || s.charAt(i) != ']' || s.charAt(i + 1) != ']') {
                            return "Invalid";
                        }
                        i += 2;
                    } else {
                        return "Invalid";
                    }
                }
            } else {
                i++;
            }
        }
        return stack.isEmpty() ? "Valid" : "Invalid";
    }
}
}