import java.util.*;

class Solution {

    Map<String, Integer> evalMap;
    String expression;
    int pos;

    public List<String> basicCalculatorIV(String expression, String[] evalvars, int[] evalints) {
        this.expression = expression;
        this.pos = 0;
        this.evalMap = new HashMap<>();
        for (int i = 0; i < evalvars.length; i++) {
            evalMap.put(evalvars[i], evalints[i]);
        }

        Map<String, Integer> finalPoly = parseExpression();

        List<String> result = new ArrayList<>();
        List<Map.Entry<String, Integer>> terms = new ArrayList<>(finalPoly.entrySet());

        terms.removeIf(entry -> entry.getValue() == 0);

        terms.sort((e1, e2) -> {
            int degree1 = getDegree(e1.getKey());
            int degree2 = getDegree(e2.getKey());
            if (degree1 != degree2) {
                return Integer.compare(degree2, degree1);
            }
            return e1.getKey().compareTo(e2.getKey());
        });

        for (Map.Entry<String, Integer> entry : terms) {
            result.add(entry.getValue() + (entry.getKey().equals("1") ? "" : "*" + entry.getKey()));
        }

        return result;
    }

    private Map<String, Integer> parseExpression() {
        Map<String, Integer> result = parseTerm();

        while (true) {
            skipSpaces();
            if (pos >= expression.length()) break;

            char op = expression.charAt(pos);
            if (op == '+' || op == '-') {
                pos++;
                Map<String, Integer> nextTerm = parseTerm();
                if (op == '+') {
                    result = add(result, nextTerm);
                } else {
                    result = subtract(result, nextTerm);
                }
            } else {
                break;
            }
        }
        return result;
    }

    private Map<String, Integer> parseTerm() {
        Map<String, Integer> result = parseFactor();

        while (true) {
            skipSpaces();
            if (pos >= expression.length()) break;

            char op = expression.charAt(pos);
            if (op == '*') {
                pos++;
                Map<String, Integer> nextFactor = parseFactor();
                result = multiply(result, nextFactor);
            } else {
                break;
            }
        }
        return result;
    }

    private Map<String, Integer> parseFactor() {
        skipSpaces();

        if (pos >= expression.length()) {
            return new HashMap<>();
        }

        char currentChar = expression.charAt(pos);
        if (currentChar == '(') {
            pos++;
            Map<String, Integer> result = parseExpression();
            skipSpaces();
            if (pos < expression.length() && expression.charAt(pos) == ')') {
                pos++;
            }
            return result;
        } else if (Character.isDigit(currentChar)) {
            return parseNumber();
        } else if (Character.isLetter(currentChar)) {
            return parseVariable();
        } else {
            return new HashMap<>();
        }
    }

    private Map<String, Integer> parseNumber() {
        int start = pos;
        while (pos < expression.length() && Character.isDigit(expression.charAt(pos))) {
            pos++;
        }
        int num = Integer.parseInt(expression.substring(start, pos));
        Map<String, Integer> poly = new HashMap<>();
        poly.put("1", num);
        return poly;
    }

    private Map<String, Integer> parseVariable() {
        int start = pos;
        while (pos < expression.length() && Character.isLetter(expression.charAt(pos))) {
            pos++;
        }
        String varName = expression.substring(start, pos);
        Map<String, Integer> poly = new HashMap<>();
        if (evalMap.containsKey(varName)) {
            poly.put("1", evalMap.get(varName));
        } else {
            poly.put(varName, 1);
        }
        return poly;
    }

    private void skipSpaces() {
        while (pos < expression.length() && expression.charAt(pos) == ' ') {
            pos++;
        }
    }

    private Map<String, Integer> add(Map<String, Integer> p1, Map<String, Integer> p2) {
        Map<String, Integer> result = new HashMap<>(p1);
        for (Map.Entry<String, Integer> entry : p2.entrySet()) {
            result.merge(entry.getKey(), entry.getValue(), Integer::sum);
        }
        return result;
    }

    private Map<String, Integer> subtract(Map<String, Integer> p1, Map<String, Integer> p2) {
        Map<String, Integer> result = new HashMap<>(p1);
        for (Map.Entry<String, Integer> entry : p2.entrySet()) {
            result.merge(entry.getKey(), -entry.getValue(), Integer::sum);
        }
        return result;
    }

    private Map<String, Integer> multiply(Map<String, Integer> p1, Map<String, Integer> p2) {
        Map<String, Integer> result = new HashMap<>();
        for (Map.Entry<String, Integer> entry1 : p1.entrySet()) {
            for (Map.Entry<String, Integer> entry2 : p2.entrySet()) {
                String newVarString = combineVarStrings(entry1.getKey(), entry2.getKey());
                int newCoefficient = entry1.getValue() * entry2.getValue();
                result.merge(newVarString, newCoefficient, Integer::sum);
            }
        }
        return result;
    }

    private String combineVarStrings(String s1, String s2) {
        if (s1.equals("1")) return s2;
        if (s2.equals("1")) return s1;

        List<String> vars = new ArrayList<>();
        if (s1.contains("*")) {
            vars.addAll(Arrays.asList(s1.split("\\*")));
        } else {
            vars.add(s1);
        }
        if (s2.contains("*")) {
            vars.addAll(Arrays.asList(s2.split("\\*")));
        } else {
            vars.add(s2);
        }
        Collections.sort(vars);
        return String.join("*", vars);
    }

    private int getDegree(String s) {
        if (s.equals("1")) return 0;
        return s.split("\\*").length;
    }
}