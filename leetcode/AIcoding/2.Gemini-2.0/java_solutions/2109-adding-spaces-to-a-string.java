class Solution {
    public String addSpaces(String s, int[] spaces) {
        StringBuilder sb = new StringBuilder();
        int spaceIndex = 0;
        int sIndex = 0;
        while (sIndex < s.length()) {
            if (spaceIndex < spaces.length && sIndex == spaces[spaceIndex]) {
                sb.append(" ");
                spaceIndex++;
            } else {
                sb.append(s.charAt(sIndex));
                sIndex++;
            }
        }
        return sb.toString();
    }
}