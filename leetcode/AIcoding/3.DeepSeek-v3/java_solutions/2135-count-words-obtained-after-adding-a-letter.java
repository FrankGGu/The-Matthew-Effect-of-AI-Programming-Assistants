class Solution {
    public int wordCount(String[] startWords, String[] targetWords) {
        Set<Integer> seen = new HashSet<>();
        for (String word : startWords) {
            int mask = 0;
            for (char c : word.toCharArray()) {
                mask |= 1 << (c - 'a');
            }
            seen.add(mask);
        }

        int res = 0;
        for (String word : targetWords) {
            int mask = 0;
            for (char c : word.toCharArray()) {
                mask |= 1 << (c - 'a');
            }
            for (char c : word.toCharArray()) {
                int temp = mask ^ (1 << (c - 'a'));
                if (seen.contains(temp)) {
                    res++;
                    break;
                }
            }
        }
        return res;
    }
}