class Solution {
    public boolean checkStrings(String s1, String s2) {
        char s1_0 = s1.charAt(0);
        char s1_1 = s1.charAt(1);
        char s1_2 = s1.charAt(2);
        char s1_3 = s1.charAt(3);

        char s2_0 = s2.charAt(0);
        char s2_1 = s2.charAt(1);
        char s2_2 = s2.charAt(2);
        char s2_3 = s2.charAt(3);

        // Check if characters at even positions can be made equal
        // This means the set {s1[0], s1[2]} must be equal to {s2[0], s2[2]}
        boolean evenPositionsMatch = (s1_0 == s2_0 && s1_2 == s2_2) || (s1_0 == s2_2 && s1_2 == s2_0);

        // Check if characters at odd positions can be made equal
        // This means the set {s1[1], s1[3]} must be equal to {s2[1], s2[3]}
        boolean oddPositionsMatch = (s1_1 == s2_1 && s1_3 == s2_3) || (s1_1 == s2_3 && s1_3 == s2_1);

        return evenPositionsMatch && oddPositionsMatch;
    }
}