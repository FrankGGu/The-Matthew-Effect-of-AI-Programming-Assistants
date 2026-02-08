import java.util.*;

class Solution {
    public int scoreOfStudents(String s, int[] answers) {
        int correctAnswer = evaluate(s);
        Set<Integer> possibleScores = new HashSet<>();
        possibleScores.add(correctAnswer);
        generatePossibleScores(s, 0, s.length() - 1, possibleScores);

        int score = 0;
        for (int answer : answers) {
            if (possibleScores.contains(answer)) {
                score += answer == correctAnswer ? 5 : 2;
            } else {
                score -= 1;
            }
        }
        return Math.max(score, 0);
    }

    private int evaluate(String s) {
        return evaluate(s, 0, s.length() - 1);
    }

    private int evaluate(String s, int left, int right) {
        int num = 0, lastNum = 0, result = 0;
        char operation = '+';
        for (int i = left; i <= right; i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                num = num * 10 + (c - '0');
            }
            if (c == '+' || c == '-' || c == '*' || i == right) {
                if (operation == '+') {
                    result += lastNum;
                    lastNum = num;
                } else if (operation == '-') {
                    result += lastNum;
                    lastNum = -num;
                } else if (operation == '*') {
                    lastNum *= num;
                }
                operation = c;
                num = 0;
            }
        }
        return result + lastNum;
    }

    private void generatePossibleScores(String s, int left, int right, Set<Integer> possibleScores) {
        for (int i = left; i < right; i++) {
            char c = s.charAt(i);
            if (c == '+' || c == '-' || c == '*') {
                generatePossibleScores(s, left, i - 1, possibleScores);
                generatePossibleScores(s, i + 1, right, possibleScores);
                for (Integer leftScore : new HashSet<>(possibleScores)) {
                    for (Integer rightScore : new HashSet<>(possibleScores)) {
                        int newScore = calculate(leftScore, rightScore, c);
                        possibleScores.add(newScore);
                    }
                }
            }
        }
    }

    private int calculate(int left, int right, char operation) {
        if (operation == '+') return left + right;
        if (operation == '-') return left - right;
        return left * right;
    }
}