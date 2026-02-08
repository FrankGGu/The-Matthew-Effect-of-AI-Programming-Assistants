class Solution {
    public int adventureCamp(String[] expeditions) {
        Set<String> known = new HashSet<>();
        if (expeditions.length == 0 || expeditions[0].length() == 0) {
            return -1;
        }
        String[] initial = expeditions[0].split("->");
        for (String site : initial) {
            known.add(site);
        }
        int maxNew = 0;
        int result = -1;
        for (int i = 1; i < expeditions.length; i++) {
            if (expeditions[i].length() == 0) {
                continue;
            }
            String[] current = expeditions[i].split("->");
            int newSites = 0;
            for (String site : current) {
                if (!known.contains(site)) {
                    known.add(site);
                    newSites++;
                }
            }
            if (newSites > maxNew) {
                maxNew = newSites;
                result = i;
            }
        }
        return result;
    }
}