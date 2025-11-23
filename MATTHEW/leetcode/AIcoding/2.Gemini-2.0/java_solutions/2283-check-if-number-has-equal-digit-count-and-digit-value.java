class Solution {
    public boolean digitCount(String num) {
        int n = num.length();
        for (int i = 0; i < n; i++) {
            int count = 0;
            for (int j = 0; j < n; j++) {
                if (Character.getNumericValue(num.charAt(j)) == i) {
                    count++;
                }
            }
            if (count != Character.getNumericValue(num.charAt(i))) {
                return false;
            }
        }
        return true;
    }
}