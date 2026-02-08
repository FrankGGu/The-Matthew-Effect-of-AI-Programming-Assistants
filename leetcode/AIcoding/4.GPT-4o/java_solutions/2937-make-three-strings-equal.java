class Solution {
    public boolean makeEqual(String[] strings) {
        int[] count = new int[26];
        for (String s : strings) {
            for (char c : s.toCharArray()) {
                count[c - 'a']++;
            }
        }
        int n = strings.length;
        for (int c : count) {
            if (c % n != 0) {
                return false;
            }
        }
        return true;
    }
}