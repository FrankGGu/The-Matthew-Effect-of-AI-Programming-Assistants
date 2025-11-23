import java.util.*;

class Solution {
    public int minimumTeachings(int n, int[][] languages, int[][] friendships) {
        // n is the number of users, but user IDs are 1 to n.
        // languages array is 0-indexed for users, so languages[i] is for user i+1.
        // friendships are 1-indexed.

        Set<Integer>[] userLanguages = new Set[n + 1];
        for (int i = 0; i < n; i++) {
            userLanguages[i + 1] = new HashSet<>();
            for (int lang : languages[i]) {
                userLanguages[i + 1].add(lang);
            }
        }

        Set<Integer> usersToFix = new HashSet<>();

        // Identify users involved in broken friendships
        for (int[] friendship : friendships) {
            int u = friendship[0];
            int v = friendship[1];

            if (!canCommunicate(userLanguages[u], userLanguages[v])) {
                usersToFix.add(u);
                usersToFix.add(v);
            }
        }

        if (usersToFix.isEmpty()) {
            return 0; // No broken friendships, no one needs to be taught.
        }

        int minPeopleToTeach = Integer.MAX_VALUE;

        // Iterate through all possible languages (1 to 500, as per constraints)
        // Max language ID is 500.
        for (int langId = 1; langId <= 500; langId++) {
            int currentTeachCount = 0;
            for (int user : usersToFix) {
                if (!userLanguages[user].contains(langId)) {
                    currentTeachCount++;
                }
            }
            minPeopleToTeach = Math.min(minPeopleToTeach, currentTeachCount);
        }

        return minPeopleToTeach;
    }

    // Helper function to check if two users can communicate
    private boolean canCommunicate(Set<Integer> langs1, Set<Integer> langs2) {
        for (int lang : langs1) {
            if (langs2.contains(lang)) {
                return true;
            }
        }
        return false;
    }
}