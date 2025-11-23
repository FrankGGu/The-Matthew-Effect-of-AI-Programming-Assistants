class Solution {
    public int largestAltitude(int[] gain) {
        int maxAltitude = 0, currentAltitude = 0;
        for (int g : gain) {
            currentAltitude += g;
            maxAltitude = Math.max(maxAltitude, currentAltitude);
        }
        return maxAltitude;
    }
}