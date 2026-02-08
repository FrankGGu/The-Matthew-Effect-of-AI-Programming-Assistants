import java.util.*;

class Solution {
    public List<String> braceExpansionII(String expression) {
        Set<String> result = evaluate(expression);
        List<String> sortedResult = new ArrayList<>(result);
        Collections.sort(sortedResult);
        return sortedResult;
    }

    private Set<String> evaluate(String expression) {
        Set<String> result = new HashSet<>();
        if (expression.isEmpty()) {
            result.add("");
            return result;
        }

        int i = 0;
        while (i < expression.length()) {
            char c = expression.charAt(i);
            if (c == '{') {
                int count = 1;
                int j = i + 1;
                while (j < expression.length() && count > 0) {
                    if (expression.charAt(j) == '{') {
                        count++;
                    } else if (expression.charAt(j) == '}') {
                        count--;
                    }
                    j++;
                }
                Set<String> innerResult = evaluate(expression.substring(i + 1, j - 1));
                if (result.isEmpty()) {
                    result.addAll(innerResult);
                } else {
                    Set<String> temp = new HashSet<>();
                    for (String s1 : result) {
                        for (String s2 : innerResult) {
                            temp.add(s1 + s2);
                        }
                    }
                    result = temp;
                }
                i = j;
            } else if (c == ',') {
                Set<String> nextResult = evaluate(expression.substring(i + 1));
                result.addAll(nextResult);
                break;
            } else {
                int j = i;
                while (j < expression.length() && expression.charAt(j) != '{' && expression.charAt(j) != ',') {
                    j++;
                }
                String str = expression.substring(i, j);
                if (result.isEmpty()) {
                    result.add(str);
                } else {
                    Set<String> temp = new HashSet<>();
                    for (String s : result) {
                        temp.add(s + str);
                    }
                    result = temp;
                }
                i = j;
            }
        }
        return result;
    }
}