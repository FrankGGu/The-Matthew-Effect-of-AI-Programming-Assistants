class Solution {
    public boolean checkDistances(String s, int[] distance) {
        int[] lastIndex = new int[26];
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            int index = c - 'a';
            if (lastIndex[index] == 0) {
                lastIndex[index] = i + 1;
            } else {
                if (i - lastIndex[index] != distance[index]) {
                    return false;
                }
            }
        }
        return true;
    }
}