class Solution {
    public String shortestMatchingSubstring(String source, String target) {
        if (source == null || target == null || source.length() == 0 || target.length() == 0) {
            return "";
        }

        int minLen = Integer.MAX_VALUE;
        String result = "";

        for (int i = 0; i < source.length(); i++) {
            for (int j = i; j < source.length(); j++) {
                String sub = source.substring(i, j + 1);
                if (sub.contains(target)) {
                    if (sub.length() < minLen) {
                        minLen = sub.length();
                        result = sub;
                    }
                }
            }
        }

        return result;
    }
}