public class Solution {

import java.util.*;

public class Solution {
    public String countOfAtoms(String formula) {
        int n = formula.length();
        Stack<Map<String, Integer>> stack = new Stack<>();
        Map<String, Integer> current = new HashMap<>();
        int i = 0;

        while (i < n) {
            char c = formula.charAt(i);
            if (c == '(') {
                stack.push(current);
                current = new HashMap<>();
                i++;
            } else if (c == ')') {
                i++;
                int j = i;
                while (j < n && Character.isDigit(formula.charAt(j))) {
                    j++;
                }
                int num = j > i ? Integer.parseInt(formula.substring(i, j)) : 1;
                i = j;
                Map<String, Integer> temp = current;
                current = stack.pop();
                for (Map.Entry<String, Integer> entry : temp.entrySet()) {
                    current.put(entry.getKey(), current.getOrDefault(entry.getKey(), 0) + entry.getValue() * num);
                }
            } else if (Character.isUpperCase(c)) {
                int j = i + 1;
                while (j < n && Character.isLowerCase(formula.charAt(j))) {
                    j++;
                }
                String name = formula.substring(i, j);
                i = j;
                j = i;
                while (j < n && Character.isDigit(formula.charAt(j))) {
                    j++;
                }
                int count = j > i ? Integer.parseInt(formula.substring(i, j)) : 1;
                current.put(name, current.getOrDefault(name, 0) + count);
                i = j;
            } else {
                i++;
            }
        }

        List<String> list = new ArrayList<>(current.keySet());
        Collections.sort(list);
        StringBuilder sb = new StringBuilder();
        for (String name : list) {
            sb.append(name);
            if (current.get(name) > 1) {
                sb.append(current.get(name));
            }
        }
        return sb.toString();
    }
}
}