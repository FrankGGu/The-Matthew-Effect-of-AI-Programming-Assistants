class Solution {
    public String complexNumberMultiply(String num1, String num2) {
        int[] c1 = parseComplex(num1);
        int[] c2 = parseComplex(num2);

        int a1 = c1[0];
        int b1 = c1[1];
        int a2 = c2[0];
        int b2 = c2[1];

        int realProduct = a1 * a2 - b1 * b2;
        int imagProduct = a1 * b2 + b1 * a2;

        return realProduct + "+" + imagProduct + "i";
    }

    private int[] parseComplex(String s) {
        int plusIndex = s.indexOf('+');
        int real = Integer.parseInt(s.substring(0, plusIndex));
        int imag = Integer.parseInt(s.substring(plusIndex + 1, s.length() - 1));
        return new int[]{real, imag};
    }
}