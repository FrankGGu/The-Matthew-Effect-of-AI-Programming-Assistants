class Solution {
    public int findTheLongestBalancedSubstring(String s) {
        int maxLen = 0;
        for (int i = 0; i < s.length(); i++) {
            for (int j = i + 1; j <= s.length(); j++) {
                String sub = s.substring(i, j);
                int zeros = 0;
                int ones = 0;
                for (char c : sub.toCharArray()) {
                    if (c == '0') {
                        zeros++;
                    } else {
                        ones++;
                    }
                }
                if (zeros == ones && isBalanced(sub)) {
                    maxLen = Math.max(maxLen, sub.length());
                }
            }
        }
        return maxLen;
    }

    private boolean isBalanced(String s) {
        int zeros = 0;
        int ones = 0;
        boolean seenOne = false;
        for (char c : s.toCharArray()) {
            if (c == '0') {
                if (seenOne) return false;
                zeros++;
            } else {
                seenOne = true;
                ones++;
            }
        }

        int firstOneIndex = -1;
        for(int i = 0; i < s.length(); ++i) {
            if(s.charAt(i) == '1') {
                firstOneIndex = i;
                break;
            }
        }
        if(firstOneIndex == -1 && s.length() != 0) return false;
        if (firstOneIndex != -1 && firstOneIndex > zeros) return false;

        int lastZeroIndex = -1;
        for(int i = s.length() -1; i >= 0; --i) {
            if(s.charAt(i) == '0') {
                lastZeroIndex = i;
                break;
            }
        }

        if (lastZeroIndex != -1 && lastZeroIndex > s.length() - ones - 1) return false;

        int zeroCount = 0;
        int oneCount = 0;
        for(int i = 0; i < s.length(); ++i) {
            if(s.charAt(i) == '0') zeroCount++;
            else oneCount++;
        }

        return true;
    }
}