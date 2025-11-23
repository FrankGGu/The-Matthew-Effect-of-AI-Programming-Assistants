public class Solution {

import java.util.*;

public class Solution {
    public int[] smallestSufficientTeam(String[] need, String[] people) {
        Map<String, Integer> skillMap = new HashMap<>();
        int skillId = 0;
        for (String skill : need) {
            if (!skillMap.containsKey(skill)) {
                skillMap.put(skill, skillId++);
            }
        }

        int n = skillId;
        int target = (1 << n) - 1;

        Map<Integer, Integer> dp = new HashMap<>();
        dp.put(0, 0);

        for (int i = 0; i < people.length; i++) {
            String personSkills = people[i];
            int personSkillMask = 0;
            for (char c : personSkills.toCharArray()) {
                personSkillMask |= 1 << skillMap.get(c);
            }

            if (personSkillMask == 0) continue;

            Map<Integer, Integer> newDp = new HashMap<>(dp);
            for (Map.Entry<Integer, Integer> entry : dp.entrySet()) {
                int currentMask = entry.getKey();
                int currentCount = entry.getValue();
                int newMask = currentMask | personSkillMask;
                if (newMask != currentMask) {
                    int newCount = currentCount + 1;
                    if (!newDp.containsKey(newMask) || newCount < newDp.get(newMask)) {
                        newDp.put(newMask, newCount);
                    }
                }
            }
            dp = newDp;
        }

        int result = dp.getOrDefault(target, 0);
        int[] answer = new int[result];
        Arrays.fill(answer, -1);
        return answer;
    }
}
}