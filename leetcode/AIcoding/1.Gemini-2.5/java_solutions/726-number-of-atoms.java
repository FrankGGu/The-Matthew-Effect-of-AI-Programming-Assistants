import java.util.Map;
import java.util.Stack;
import java.util.TreeMap;

class Solution {
    public String countOfAtoms(String formula) {
        Stack<Map<String, Integer>> stack = new Stack<>();
        stack.push(new TreeMap<>()); // Global map for atom counts

        int n = formula.length();
        int i = 0;

        while (i < n) {
            char c = formula.charAt(i);

            if (c == '(') {
                stack.push(new TreeMap<>()); // New map for the sub-formula
                i++;
            } else if (c == ')') {
                i++;
                int multiplier = 0;
                while (i < n && Character.isDigit(formula.charAt(i))) {
                    multiplier = multiplier * 10 + (formula.charAt(i) - '0');
                    i++;
                }
                if (multiplier == 0) {
                    multiplier = 1;
                }

                Map<String, Integer> poppedMap = stack.pop();
                Map<String, Integer> prevMap = stack.peek();
                for (Map.Entry<String, Integer> entry : poppedMap.entrySet()) {
                    prevMap.put(entry.getKey(), prevMap.getOrDefault(entry.getKey(), 0) + entry.getValue() * multiplier);
                }
            } else { // Element symbol
                StringBuilder atomNameBuilder = new StringBuilder();
                atomNameBuilder.append(c); // First char is uppercase
                i++;
                while (i < n && Character.isLowerCase(formula.charAt(i))) {
                    atomNameBuilder.append(formula.charAt(i));
                    i++;
                }
                String atomName = atomNameBuilder.toString();

                int count = 0;
                while (i < n && Character.isDigit(formula.charAt(i))) {
                    count = count * 10 + (formula.charAt(i) - '0');
                    i++;
                }
                if (count == 0) { // If no number after atom, count is 1
                    count = 1;
                }

                Map<String, Integer> currentMap = stack.peek();
                currentMap.put(atomName, currentMap.getOrDefault(atomName, 0) + count);
            }
        }

        StringBuilder result = new StringBuilder();
        Map<String, Integer> finalMap = stack.pop(); // Should be the only map left
        for (Map.Entry<String, Integer> entry : finalMap.entrySet()) {
            result.append(entry.getKey());
            if (entry.getValue() > 1) {
                result.append(entry.getValue());
            }
        }

        return result.toString();
    }
}