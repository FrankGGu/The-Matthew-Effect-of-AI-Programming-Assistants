import java.util.*;

public class Solution {
    public List<String> basicCalculatorIV(String expression, String[] evalvars, int[] evalints) {
        Map<String, Integer> evalMap = new HashMap<>();
        for (int i = 0; i < evalvars.length; i++) {
            evalMap.put(evalvars[i], evalints[i]);
        }
        return evaluate(expression, evalMap);
    }

    private List<String> evaluate(String expression, Map<String, Integer> evalMap) {
        Map<String, Integer> termFreq = new HashMap<>();
        Stack<Map<String, Integer>> stack = new Stack<>();
        Stack<Integer> signStack = new Stack<>();
        int sign = 1;
        int i = 0;
        expression += " ";

        while (i < expression.length()) {
            char c = expression.charAt(i);
            if (Character.isDigit(c)) {
                int num = 0;
                while (i < expression.length() && Character.isDigit(expression.charAt(i))) {
                    num = num * 10 + (expression.charAt(i) - '0');
                    i++;
                }
                termFreq.put("", termFreq.getOrDefault("", 0) + sign * num);
            } else if (Character.isLetter(c)) {
                StringBuilder var = new StringBuilder();
                while (i < expression.length() && Character.isLetter(expression.charAt(i))) {
                    var.append(expression.charAt(i));
                    i++;
                }
                String varStr = var.toString();
                if (evalMap.containsKey(varStr)) {
                    termFreq.put("", termFreq.getOrDefault("", 0) + sign * evalMap.get(varStr));
                } else {
                    termFreq.put(varStr, termFreq.getOrDefault(varStr, 0) + sign);
                }
            } else if (c == '+') {
                sign = 1;
                i++;
            } else if (c == '-') {
                sign = -1;
                i++;
            } else if (c == '(') {
                stack.push(new HashMap<>(termFreq));
                signStack.push(sign);
                termFreq.clear();
                sign = 1;
                i++;
            } else if (c == ')') {
                Map<String, Integer> prevFreq = stack.pop();
                int prevSign = signStack.pop();
                for (Map.Entry<String, Integer> entry : termFreq.entrySet()) {
                    prevFreq.put(entry.getKey(), prevFreq.getOrDefault(entry.getKey(), 0) + entry.getValue() * prevSign);
                }
                termFreq = prevFreq;
                i++;
            } else {
                i++;
            }
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : termFreq.entrySet()) {
            if (entry.getValue() != 0) {
                String term = entry.getValue() == 1 ? "" : entry.getValue() == -1 ? "-" : entry.getValue().toString();
                if (!entry.getKey().isEmpty()) {
                    term += entry.getKey();
                }
                result.add(term);
            }
        }
        Collections.sort(result);
        return result;
    }
}