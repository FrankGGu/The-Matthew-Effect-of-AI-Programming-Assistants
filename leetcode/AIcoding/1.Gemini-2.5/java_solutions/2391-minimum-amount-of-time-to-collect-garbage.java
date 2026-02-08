class Solution {
    public int garbageCollection(String[] garbage, int[] travel) {
        int totalTime = 0;

        int lastM = -1;
        int lastP = -1;
        int lastG = -1;

        // Calculate pickup times and find the last house for each garbage type
        for (int i = 0; i < garbage.length; i++) {
            String houseGarbage = garbage[i];
            totalTime += houseGarbage.length(); // Add time to pick up all garbage at current house

            for (char c : houseGarbage.toCharArray()) {
                if (c == 'M') {
                    lastM = i;
                } else if (c == 'P') {
                    lastP = i;
                } else if (c == 'G') {
                    lastG = i;
                }
            }
        }

        // Calculate prefix sums for travel times
        // prefixTravel[i] stores the time to travel from house 0 to house i
        int[] prefixTravel = new int[travel.length + 1];
        prefixTravel[0] = 0;
        for (int i = 0; i < travel.length; i++) {
            prefixTravel[i + 1] = prefixTravel[i] + travel[i];
        }

        // Add travel times for each truck
        if (lastM != -1) {
            totalTime += prefixTravel[lastM];
        }
        if (lastP != -1) {
            totalTime += prefixTravel[lastP];
        }
        if (lastG != -1) {
            totalTime += prefixTravel[lastG];
        }

        return totalTime;
    }
}