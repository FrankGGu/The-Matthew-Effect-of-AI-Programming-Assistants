class Solution {
    public String shortestBeautifulSubstring(String s, int k) {
        int n = s.length();
        String result = "";
        int left = 0;
        int count = 0;

        for (int right = 0; right < n; right++) {
            if (s.charAt(right) == '1') {
                count++;
            }

            while (count == k) {
                String current = s.substring(left, right + 1);
                if (result.isEmpty() || current.length() < result.length()) {
                    result = current;
                } else if (current.length() == result.length() && current.compareTo(result) < 0) {
                    result = current;
                }

                if (s.charAt(left) == '1') {
                    count--;
                }
                left++;
            }
        }

        return result;
    }
}