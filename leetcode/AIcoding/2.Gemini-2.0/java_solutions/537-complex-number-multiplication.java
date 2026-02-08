class Solution {
    public String complexNumberMultiply(String num1, String num2) {
        String[] parts1 = num1.split("\\+");
        String[] parts2 = num2.split("\\+");

        int real1 = Integer.parseInt(parts1[0]);
        int imag1 = Integer.parseInt(parts1[1].replace("i", ""));

        int real2 = Integer.parseInt(parts2[0]);
        int imag2 = Integer.parseInt(parts2[1].replace("i", ""));

        int realPart = (real1 * real2) - (imag1 * imag2);
        int imagPart = (real1 * imag2) + (real2 * imag1);

        return realPart + "+" + imagPart + "i";
    }
}