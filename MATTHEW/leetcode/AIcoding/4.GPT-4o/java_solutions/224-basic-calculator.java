class Solution {
    public int calculate(String s) {
        int n = s.length(), currentNumber = 0, result = 0, lastNumber = 0;
        char operation = '+';
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                currentNumber = currentNumber * 10 + (c - '0');
            }
            if (!Character.isDigit(c) && c != ' ' || i == n - 1) {
                if (operation == '+') {
                    result += lastNumber;
                    lastNumber = currentNumber;
                } else if (operation == '-') {
                    result += lastNumber;
                    lastNumber = -currentNumber;
                } else if (operation == '*') {
                    lastNumber *= currentNumber;
                } else if (operation == '/') {
                    lastNumber /= currentNumber;
                }
                operation = c;
                currentNumber = 0;
            }
        }
        return result + lastNumber;
    }
}