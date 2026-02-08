public class Solution {
    public String complexNumberMultiply(String a, String b) {
        int[] num1 = parseComplex(a);
        int[] num2 = parseComplex(b);
        int real = num1[0] * num2[0] - num1[1] * num2[1];
        int imag = num1[0] * num2[1] + num1[1] * num2[0];
        return real + "+" + imag + "i";
    }

    private int[] parseComplex(String s) {
        int[] result = new int[2];
        int i = 0;
        if (s.charAt(0) == '-') {
            i++;
        }
        int real = 0;
        while (s.charAt(i) != '+') {
            real = real * 10 + (s.charAt(i) - '0');
            i++;
        }
        result[0] = real;
        i++;
        int imag = 0;
        boolean negative = false;
        if (s.charAt(i) == '-') {
            negative = true;
            i++;
        }
        while (i < s.length() - 1) {
            imag = imag * 10 + (s.charAt(i) - '0');
            i++;
        }
        if (negative) {
            imag = -imag;
        }
        result[1] = imag;
        return result;
    }
}