class Solution {
    public boolean splitString(String s) {
        for (int i = 0; i < s.length() - 1; i++) {
            String firstNumStr = s.substring(0, i + 1);
            long firstNum;
            try {
                firstNum = Long.parseLong(firstNumStr);
            } catch (NumberFormatException e) {
                if (firstNumStr.length() > 19) {
                    break;
                }
                continue;
            }

            if (backtrack(s, i + 1, firstNum, 1)) {
                return true;
            }
        }
        return false;
    }

    private boolean backtrack(String s, int index, long prevVal, int count) {
        if (index == s.length()) {
            return count >= 2;
        }

        for (int i = index; i < s.length(); i++) {
            String currentNumStr = s.substring(index, i + 1);
            long currentNum;

            try {
                currentNum = Long.parseLong(currentNumStr);
            } catch (NumberFormatException e) {
                break;
            }

            if (currentNum == prevVal - 1) {
                if (backtrack(s, i + 1, currentNum, count + 1)) {
                    return true;
                }
            } else if (currentNum > prevVal - 1) {
                break;
            }
        }
        return false;
    }
}