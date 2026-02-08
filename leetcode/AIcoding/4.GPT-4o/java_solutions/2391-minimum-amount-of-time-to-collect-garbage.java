class Solution {
    public int garbageCollection(String[] garbage, int[] travel) {
        int totalTime = 0, lastG = 0, lastP = 0, lastM = 0;
        for (int i = 0; i < garbage.length; i++) {
            totalTime += garbage[i].length();
            if (garbage[i].contains("G")) lastG = i;
            if (garbage[i].contains("P")) lastP = i;
            if (garbage[i].contains("M")) lastM = i;
        }
        for (int i = 0; i < lastG; i++) totalTime += travel[i];
        for (int i = 0; i < lastP; i++) totalTime += travel[i];
        for (int i = 0; i < lastM; i++) totalTime += travel[i];
        return totalTime;
    }
}