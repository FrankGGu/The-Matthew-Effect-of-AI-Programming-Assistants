public class Solution {
    public int numWays(String s) {
        int mod = 1000000007;
        int count = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') count++;
        }
        if (count % 2 != 0) return 0;
        if (count == 0) return (s.length() - 1) % mod;
        int half = count / 2;
        int first = 0;
        int second = 0;
        int i = 0;
        while (i < s.length() && first < half) {
            if (s.charAt(i) == '1') first++;
            i++;
        }
        i++;
        while (i < s.length() && second < half) {
            if (s.charAt(i) == '1') second++;
            i++;
        }
        int left = 0;
        int right = 0;
        i = 0;
        while (i < s.length() && s.charAt(i) == '0') {
            left++;
            i++;
        }
        i = s.length() - 1;
        while (i >= 0 && s.charAt(i) == '0') {
            right++;
            i--;
        }
        return (left + 1) * (right + 1) % mod;
    }
}