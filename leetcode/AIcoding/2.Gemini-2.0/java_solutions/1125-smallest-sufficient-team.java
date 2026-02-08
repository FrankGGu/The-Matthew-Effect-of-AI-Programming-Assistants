import java.util.*;

class Solution {
    public int[] smallestSufficientTeam(String[] req_skills, List<List<String>> people) {
        int n = req_skills.length;
        Map<String, Integer> skillMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            skillMap.put(req_skills[i], i);
        }

        int[] skills = new int[people.size()];
        for (int i = 0; i < people.size(); i++) {
            for (String skill : people.get(i)) {
                if (skillMap.containsKey(skill)) {
                    skills[i] |= (1 << skillMap.get(skill));
                }
            }
        }

        Map<Integer, List<Integer>> dp = new HashMap<>();
        dp.put(0, new ArrayList<>());

        for (int i = 0; i < people.size(); i++) {
            for (int mask : new ArrayList<>(dp.keySet())) {
                int newMask = mask | skills[i];
                if (!dp.containsKey(newMask) || dp.get(mask).size() + 1 < dp.get(newMask).size()) {
                    List<Integer> newTeam = new ArrayList<>(dp.get(mask));
                    newTeam.add(i);
                    dp.put(newMask, newTeam);
                }
            }
        }

        List<Integer> resultList = dp.get((1 << n) - 1);
        int[] result = new int[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            result[i] = resultList.get(i);
        }
        return result;
    }
}