class Solution {
    public int secondsToRemoveOccurrences(String s) {
        int count = 0;
        while (true) {
            boolean changed = false;
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < s.length(); i++) {
                if (s.charAt(i) == '0') {
                    sb.append('0');
                } else {
                    if (i + 1 < s.length() && s.charAt(i + 1) == '0') {
                        sb.append('0');
                        i++;
                        sb.append('1');
                        changed = true;
                    } else {
                        sb.append('1');
                    }
                }
            }
            s = sb.toString();
            if (!changed) {
                break;
            }
            count++;
        }
        return count;
    }
}