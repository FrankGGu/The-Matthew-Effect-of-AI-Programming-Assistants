public class Solution {
    public String categorizeBox(double length, double width, double height) {
        long l = (long) length;
        long w = (long) width;
        long h = (long) height;
        long volume = l * w * h;
        boolean isLargeVolume = volume >= 1e9;
        boolean isHeavy = l >= 1e4 || w >= 1e4 || h >= 1e4;
        if (isLargeVolume && isHeavy) {
            return "Both";
        } else if (isLargeVolume) {
            return "Volume";
        } else if (isHeavy) {
            return "Weight";
        } else {
            return "Neither";
        }
    }
}