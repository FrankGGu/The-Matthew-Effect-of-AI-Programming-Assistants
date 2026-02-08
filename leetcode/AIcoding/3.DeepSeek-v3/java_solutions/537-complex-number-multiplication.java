class Solution {
    public String complexNumberMultiply(String num1, String num2) {
        int[] a = parseComplex(num1);
        int[] b = parseComplex(num2);
        int real = a[0] * b[0] - a[1] * b[1];
        int imaginary = a[0] * b[1] + a[1] * b[0];
        return real + "+" + imaginary + "i";
    }

    private int[] parseComplex(String num) {
        String[] parts = num.split("\\+|i");
        int real = Integer.parseInt(parts[0]);
        int imaginary = Integer.parseInt(parts[1]);
        return new int[]{real, imaginary};
    }
}