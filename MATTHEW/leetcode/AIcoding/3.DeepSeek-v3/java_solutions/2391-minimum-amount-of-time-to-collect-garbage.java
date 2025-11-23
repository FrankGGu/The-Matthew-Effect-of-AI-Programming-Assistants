class Solution {
    public int garbageCollection(String[] garbage, int[] travel) {
        int[] lastOccurrence = new int[3]; // M, P, G
        int totalTime = 0;

        for (int i = 0; i < garbage.length; i++) {
            String current = garbage[i];
            totalTime += current.length();

            if (current.contains("M")) {
                lastOccurrence[0] = i;
            }
            if (current.contains("P")) {
                lastOccurrence[1] = i;
            }
            if (current.contains("G")) {
                lastOccurrence[2] = i;
            }
        }

        int[] prefixSum = new int[travel.length + 1];
        for (int i = 1; i <= travel.length; i++) {
            prefixSum[i] = prefixSum[i - 1] + travel[i - 1];
        }

        for (int i = 0; i < 3; i++) {
            if (lastOccurrence[i] > 0) {
                totalTime += prefixSum[lastOccurrence[i]];
            }
        }

        return totalTime;
    }
}