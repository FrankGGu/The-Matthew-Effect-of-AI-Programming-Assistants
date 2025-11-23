class Solution {
    public String categorizeBox(int length, int width, int height, int mass) {
        boolean isBulky = false;
        boolean isHeavy = false;

        long volume = (long) length * width * height;

        if (volume >= 1_000_000_000L || length >= 10000 || width >= 10000 || height >= 10000) {
            isBulky = true;
        }

        if (mass >= 100) {
            isHeavy = true;
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