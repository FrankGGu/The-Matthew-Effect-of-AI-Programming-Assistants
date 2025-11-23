class Solution {
    public String categorizeBox(int length, int width, int height, int weight) {
        boolean bulky = length >= 10000 || width >= 10000 || height >= 10000 || (length * width * height) >= 1000000000;
        boolean heavy = weight >= 100;

        if (bulky && heavy) return "Both";
        if (bulky) return "Bulky";
        if (heavy) return "Heavy";
        return "Neither";
    }
}