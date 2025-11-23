class Solution {
    public int maximumRequests(int n, int[][] requests) {
        int maxAchievableRequests = 0;
        int numRequests = requests.length;

        // Iterate through all possible subsets of requests using a bitmask
        // A mask from 0 to 2^numRequests - 1 represents each subset
        for (int i = 0; i < (1 << numRequests); i++) {
            int[] balance = new int[n]; // Tracks net change for each building
            int currentRequestsCount = 0;

            // Check each request in the current subset
            for (int j = 0; j < numRequests; j++) {
                // If the j-th bit is set in the mask, include this request
                if (((i >> j) & 1) == 1) {
                    currentRequestsCount++;
                    int from = requests[j][0];
                    int to = requests[j][1];
                    balance[from]--; // Employee leaves 'from' building
                    balance[to]++;   // Employee arrives at 'to' building
                }
            }

            // Check if this subset of requests is valid (all buildings have zero net change)
            boolean isValid = true;
            for (int k = 0; k < n; k++) {
                if (balance[k] != 0) {
                    isValid = false;
                    break;
                }
            }

            // If valid, update the maximum achievable requests
            if (isValid) {
                maxAchievableRequests = Math.max(maxAchievableRequests, currentRequestsCount);
            }
        }

        return maxAchievableRequests;
    }
}