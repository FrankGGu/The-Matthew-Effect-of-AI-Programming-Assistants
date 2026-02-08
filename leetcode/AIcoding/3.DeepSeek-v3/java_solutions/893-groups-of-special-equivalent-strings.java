class Solution {
    public int numSpecialEquivGroups(String[] A) {
        Set<String> seen = new HashSet<>();
        for (String s : A) {
            int[] count = new int[52];
            for (int i = 0; i < s.length(); i++) {
                char c = s.charAt(i);
                count[c - 'a' + 26 * (i % 2)]++;
            }
            seen.add(Arrays.toString(count));
        }
        return seen.size();
    }
}