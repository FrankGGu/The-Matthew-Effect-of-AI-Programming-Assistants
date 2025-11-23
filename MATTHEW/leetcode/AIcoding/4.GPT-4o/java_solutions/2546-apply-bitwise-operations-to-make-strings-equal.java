class Solution {
    public boolean makeStringsEqual(String s, String target) {
        if (s.equals(target)) return true;
        return (s.contains("1") && target.contains("1")) || (s.contains("0") && target.contains("0"));
    }
}