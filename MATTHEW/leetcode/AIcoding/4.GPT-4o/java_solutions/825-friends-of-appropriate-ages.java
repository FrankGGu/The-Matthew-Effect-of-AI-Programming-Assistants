class Solution {
    public int numFriendRequests(int[] ages) {
        int count = 0;
        for (int i = 0; i < ages.length; i++) {
            for (int j = 0; j < ages.length; j++) {
                if (i != j && isRequestAllowed(ages[i], ages[j])) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isRequestAllowed(int ageA, int ageB) {
        return !(ageB <= 0.5 * ageA + 7 || ageB > ageA || (ageA < 100 && ageB > ageA));
    }
}