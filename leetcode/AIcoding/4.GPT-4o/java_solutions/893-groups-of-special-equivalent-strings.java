import java.util.HashSet;

class Solution {
    public int numSpecialEquivGroups(String[] A) {
        HashSet<String> set = new HashSet<>();
        for (String s : A) {
            int[] count = new int[52];
            for (int i = 0; i < s.length(); i++) {
                count[s.charAt(i) - 'a' + (i % 2) * 26]++;
            }
            set.add(Arrays.toString(count));
        }
        return set.size();
    }
}