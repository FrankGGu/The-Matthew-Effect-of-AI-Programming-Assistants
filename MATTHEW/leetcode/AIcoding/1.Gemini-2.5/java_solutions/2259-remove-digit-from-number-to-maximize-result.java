class Solution {
    public String removeDigit(String number, char digit) {
        String maxResult = "";
        int n = number.length();

        for (int i = 0; i < n; i++) {
            if (number.charAt(i) == digit) {
                String currentCandidate = new StringBuilder(number).deleteCharAt(i).toString();
                if (maxResult.isEmpty() || currentCandidate.compareTo(maxResult) > 0) {
                    maxResult = currentCandidate;
                }
            }
        }
        return maxResult;
    }
}