class Solution {
    public int minimizeStringLength(String s) {
        return (int) s.chars().distinct().count();
    }
}