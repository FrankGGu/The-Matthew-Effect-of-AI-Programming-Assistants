class Solution {
    public String categorizeBox(int length, int width, int height, int mass) {
        boolean isBulky = false;
        boolean isHeavy = mass >= 100;

        long volume = (long) length * width * height;
        if (length >= 10000 || width >= 10000 || height >= 10000 || volume >= 1000000000L) {
            isBulky = true;
        }

        if (isBulky && isHeavy) {
            return "Both";
        } else if (isBulky) {
            return "Bulky";
        } else if (isHeavy) {
            return "Heavy";
        } else {
            return "Neither";
        }
    }
}