class Solution {
    public String smallestBeautifulString(String s, int k) {
        char[] result = s.toCharArray();
        int n = result.length;

        for (int i = n - 1; i >= 0; i--) {
            result[i]++;
            while (result[i] - 'a' >= k || (i > 0 && result[i] == result[i - 1]) || (i > 1 && result[i] == result[i - 2])) {
                result[i]++;
            }
            if (result[i] - 'a' < k) {
                break;
            }
            result[i] = 'a'; // reset and carry over
        }

        if (result[0] - 'a' >= k) {
            return "";
        }

        for (int i = 0; i < n; i++) {
            if (result[i] - 'a' >= k) {
                return "";
            }
            while (i > 0 && result[i] == result[i - 1]) {
                result[i]++;
            }
            if (result[i] - 'a' >= k) {
                return "";
            }
        }

        return new String(result);
    }
}