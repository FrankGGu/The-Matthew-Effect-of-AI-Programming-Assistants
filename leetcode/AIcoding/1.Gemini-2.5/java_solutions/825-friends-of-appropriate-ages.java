class Solution {
    public int numFriendRequests(int[] ages) {
        int[] ageCounts = new int[121]; // Ages are 1 to 120
        for (int age : ages) {
            ageCounts[age]++;
        }

        int totalRequests = 0;
        for (int ageA = 1; ageA <= 120; ageA++) {
            if (ageCounts[ageA] == 0) {
                continue;
            }
            for (int ageB = 1; ageB <= 120; ageB++) {
                if (ageCounts[ageB] == 0) {
                    continue;
                }

                // Conditions for A to send a request to B:
                // 1. ageB > 0.5 * ageA + 7
                // 2. ageB <= ageA
                // 3. ageB <= 100 || ageA >= 100 (This condition is always true for ages 1-120 and can be ignored)

                // Using integer arithmetic for condition 1:
                // ageB > 0.5 * ageA + 7  =>  2 * ageB > ageA + 14
                boolean condition1 = (2 * ageB > ageA + 14);
                boolean condition2 = (ageB <= ageA);

                if (condition1 && condition2) {
                    if (ageA == ageB) {
                        // If ageA == ageB, a person cannot send a request to themselves.
                        // So, for 'ageCounts[ageA]' people of age 'ageA', each can send a request
                        // to 'ageCounts[ageA] - 1' other people of the same age.
                        totalRequests += ageCounts[ageA] * (ageCounts[ageA] - 1);
                    } else {
                        // If ageA != ageB, all 'ageCounts[ageA]' people can send requests
                        // to all 'ageCounts[ageB]' people.
                        totalRequests += ageCounts[ageA] * ageCounts[ageB];
                    }
                }
            }
        }
        return totalRequests;
    }
}