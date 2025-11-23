class Solution {
    public long distinctNames(String[] ideas) {
        HashSet<String>[] groups = new HashSet[26];
        for (int i = 0; i < 26; i++) {
            groups[i] = new HashSet<>();
        }
        for (String idea : ideas) {
            groups[idea.charAt(0) - 'a'].add(idea.substring(1));
        }

        long res = 0;
        for (int i = 0; i < 25; i++) {
            for (int j = i + 1; j < 26; j++) {
                int common = 0;
                for (String suffix : groups[i]) {
                    if (groups[j].contains(suffix)) {
                        common++;
                    }
                }
                res += 2 * (groups[i].size() - common) * (groups[j].size() - common);
            }
        }
        return res;
    }
}