class Solution {
    public boolean isCyclic(String s1, String s2) {
        if (s1.length() + s2.length() == 0) return true;
        if (s1.length() + s2.length() == 0) return false;
        String s = s1 + s1;
        return s.contains(s2);
    }

    public boolean checkStringExist(String s1, String s2) {
        return isCyclic(s1, s2) && isCyclic(s2, s1);
    }
}