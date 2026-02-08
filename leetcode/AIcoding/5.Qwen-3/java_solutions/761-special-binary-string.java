public class Solution {
    public String splitLoopedString(String[] strs) {
        int n = strs.length;
        StringBuilder[] sbs = new StringBuilder[n];
        for (int i = 0; i < n; i++) {
            sbs[i] = new StringBuilder(strs[i]);
            if (strs[i].equals(sbs[i].reverse().toString())) {
                continue;
            }
            sbs[i] = new StringBuilder(strs[i]);
        }

        String res = "";
        for (int i = 0; i < n; i++) {
            String s = sbs[i].toString();
            String rev = sbs[i].reverse().toString();
            for (int j = 0; j < s.length(); j++) {
                String curr = s.substring(j) + s.substring(0, j);
                String revCurr = rev.substring(j) + rev.substring(0, j);
                String candidate = curr;
                if (revCurr.compareTo(curr) > 0) {
                    candidate = revCurr;
                }
                for (int k = 0; k < n; k++) {
                    if (k == i) {
                        continue;
                    }
                    candidate += sbs[k].toString();
                }
                if (candidate.compareTo(res) > 0) {
                    res = candidate;
                }
            }
        }
        return res;
    }
}