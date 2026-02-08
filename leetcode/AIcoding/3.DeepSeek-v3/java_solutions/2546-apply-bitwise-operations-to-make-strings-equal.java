class Solution {
    public boolean makeStringsEqual(String s, String target) {
        int count1 = 0, count2 = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') count1++;
        }
        for (char c : target.toCharArray()) {
            if (c == '1') count2++;
        }
        if (count1 == 0) return count2 == 0;
        return count2 != 0;
    }
}