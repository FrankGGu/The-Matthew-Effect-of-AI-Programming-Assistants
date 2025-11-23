class Solution {
    public boolean repeatedSubstringPattern(String s) {
        String doubledS = s + s;
        String sub = doubledS.substring(1, doubledS.length() - 1);
        return sub.contains(s);
    }
}