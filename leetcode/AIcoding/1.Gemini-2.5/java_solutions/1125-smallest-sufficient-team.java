import java.util.*;

class Solution {
    public int[] smallestSufficientTeam(String[] req_skills, List<List<String>> people) {
        int m = req_skills.length;
        int n = people.size();

        Map<String, Integer> skillMap = new HashMap<>();
        for (int i = 0; i < m; i++) {
            skillMap.put(req_skills[i], i);
        }

        int[] peopleSkills = new int[n];
        for (int i = 0; i < n; i++) {
            int currentPersonMask = 0;
            for (String skill : people.get(i)) {
                if (skillMap.containsKey(skill)) { // Ensure skill is one of the required skills
                    currentPersonMask |= (1 << skillMap.get(skill));
                }
            }
            peopleSkills[i] = currentPersonMask;
        }

        long[] dp = new long[1 << m];
        Arrays.fill(dp, (1L << n)); 
        dp[0] = 0L; 

        for (int mask = 0; mask < (1 << m); mask++) {
            if (dp[mask] == (1L << n)) {
                continue;
            }

            for (int pIdx = 0; pIdx < n; pIdx++) {
                int personSkillMask = peopleSkills[pIdx];
                int newMask = mask | personSkillMask;
                long newTeam = dp[mask] | (1L << pIdx);

                if (Long.bitCount(newTeam) < Long.bitCount(dp[newMask])) {
                    dp[newMask] = newTeam;
                }
            }
        }

        long resultMask = dp[(1 << m) - 1];

        List<Integer> ansList = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (((resultMask >> i) & 1) == 1) {
                ansList.add(i);
            }
        }

        int[] ans = new int[ansList.size()];
        for (int i = 0; i < ansList.size(); i++) {
            ans[i] = ansList.get(i);
        }
        return ans;
    }
}