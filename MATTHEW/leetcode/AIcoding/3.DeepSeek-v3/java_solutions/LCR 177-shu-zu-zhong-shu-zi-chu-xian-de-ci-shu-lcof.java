class Solution {
    public List<List<Integer>> colorThemes(int[] colors) {
        List<List<Integer>> result = new ArrayList<>();
        Set<Integer> seen = new HashSet<>();
        for (int i = 0; i < colors.length; i++) {
            if (seen.contains(colors[i])) {
                continue;
            }
            seen.add(colors[i]);
            for (int j = i + 1; j < colors.length; j++) {
                if ((colors[i] ^ colors[j]) == 0) {
                    continue;
                }
                List<Integer> pair = new ArrayList<>();
                pair.add(colors[i]);
                pair.add(colors[j]);
                result.add(pair);
            }
        }
        return result;
    }
}