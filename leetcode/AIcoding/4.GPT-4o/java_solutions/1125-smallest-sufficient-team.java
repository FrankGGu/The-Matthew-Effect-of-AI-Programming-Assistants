import java.util.*;

public class Solution {
    public List<Integer> smallestSufficientTeam(String[] reqSkills, List<List<String>> people) {
        int n = reqSkills.length;
        Map<String, Integer> skillIndex = new HashMap<>();
        for (int i = 0; i < n; i++) {
            skillIndex.put(reqSkills[i], i);
        }

        int m = people.size();
        int[] peopleSkills = new int[m];
        for (int i = 0; i < m; i++) {
            for (String skill : people.get(i)) {
                if (skillIndex.containsKey(skill)) {
                    peopleSkills[i] |= (1 << skillIndex.get(skill));
                }
            }
        }

        int target = (1 << n) - 1;
        Map<Integer, List<Integer>> dp = new HashMap<>();
        dp.put(0, new ArrayList<>());

        for (int i = 0; i < m; i++) {
            int skillSet = peopleSkills[i];
            for (int curr = target; curr >= 0; curr--) {
                if (dp.containsKey(curr)) {
                    int newSkills = curr | skillSet;
                    if (!dp.containsKey(newSkills) || dp.get(newSkills).size() > dp.get(curr).size() + 1) {
                        List<Integer> newTeam = new ArrayList<>(dp.get(curr));
                        newTeam.add(i);
                        dp.put(newSkills, newTeam);
                    }
                }
            }
        }
        return dp.get(target);
    }
}