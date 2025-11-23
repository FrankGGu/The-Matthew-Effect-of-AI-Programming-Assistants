class Solution {
    public int garbageCollection(String[] garbage, int[] travel) {
        int lastM = 0, lastP = 0, lastG = 0;
        int countM = 0, countP = 0, countG = 0;
        int travelM = 0, travelP = 0, travelG = 0;

        for (int i = 0; i < garbage.length; i++) {
            for (char c : garbage[i].toCharArray()) {
                if (c == 'M') {
                    countM++;
                    lastM = i;
                } else if (c == 'P') {
                    countP++;
                    lastP = i;
                } else {
                    countG++;
                    lastG = i;
                }
            }
        }

        for (int i = 0; i < lastM; i++) {
            travelM += travel[i];
        }
        for (int i = 0; i < lastP; i++) {
            travelP += travel[i];
        }
        for (int i = 0; i < lastG; i++) {
            travelG += travel[i];
        }

        return countM + countP + countG + travelM + travelP + travelG;
    }
}