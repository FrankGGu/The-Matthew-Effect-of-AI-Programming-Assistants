class Solution {
    public String[] splitMessage(String message, int limit) {
        int n = message.length();
        int parts = 0;
        int total = 0;

        for (parts = 1; parts <= n; parts++) {
            int suffixLen = String.valueOf(parts).length() * 2 + 3;
            if (limit <= suffixLen) {
                return new String[0];
            }
            total = parts * (limit - suffixLen);
            if (total >= n) {
                break;
            }
        }

        if (parts > n) {
            return new String[0];
        }

        String[] result = new String[parts];
        int index = 0;
        for (int i = 1; i <= parts; i++) {
            int suffixLen = String.valueOf(i).length() + String.valueOf(parts).length() + 3;
            int maxLen = limit - suffixLen;
            int end = Math.min(index + maxLen, message.length());
            String part = message.substring(index, end) + "<" + i + "/" + parts + ">";
            result[i - 1] = part;
            index = end;
        }

        return result;
    }
}