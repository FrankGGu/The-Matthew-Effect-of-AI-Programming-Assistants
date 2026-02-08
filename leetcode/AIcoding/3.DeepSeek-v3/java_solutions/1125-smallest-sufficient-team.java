class Solution {
    public int[] smallestSufficientTeam(String[] req_skills, List<List<String>> people) {
        int n = req_skills.length;
        int m = people.size();
        Map<String, Integer> skillToIndex = new HashMap<>();
        for (int i = 0; i < n; i++) {
            skillToIndex.put(req_skills[i], i);
        }

        int[] peopleSkills = new int[m];
        for (int i = 0; i < m; i++) {
            int mask = 0;
            for (String skill : people.get(i)) {
                mask |= 1 << skillToIndex.get(skill);
            }
            peopleSkills[i] = mask;
        }

        int target = (1 << n) - 1;
        Map<Integer, List<Integer>> dp = new HashMap<>();
        dp.put(0, new ArrayList<>());

        for (int i = 0; i < m; i++) {
            Map<Integer, List<Integer>> newDp = new HashMap<>(dp);
            for (int mask : dp.keySet()) {
                int newMask = mask | peopleSkills[i];
                if (!newDp.containsKey(newMask) || newDp.get(newMask).size() > dp.get(mask).size() + 1) {
                    List<Integer> team = new ArrayList<>(dp.get(mask));
                    team.add(i);
                    newDp.put(newMask, team);
                }
            }
            dp = newDp;
        }

        List<Integer> team = dp.get(target);
        int[] result = new int[team.size()];
        for (int i = 0; i < team.size(); i++) {
            result[i] = team.get(i);
        }
        return result;
    }
}