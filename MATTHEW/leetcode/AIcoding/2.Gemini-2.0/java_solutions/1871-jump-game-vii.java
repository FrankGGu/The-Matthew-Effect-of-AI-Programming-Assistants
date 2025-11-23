class Solution {
    public boolean canReach(String s, int minJump, int maxJump) {
        int n = s.length();
        if (s.charAt(n - 1) == '1') {
            return false;
        }

        boolean[] reachable = new boolean[n];
        reachable[0] = true;
        int pre = 0;

        for (int i = 1; i < n; i++) {
            if (s.charAt(i) == '0') {
                while (pre < i - maxJump) {
                    pre++;
                }
                for (int j = Math.max(pre, i - maxJump); j <= Math.min(i - minJump, n - 1); j++) {
                    if (reachable[j]) {
                        reachable[i] = true;
                        break;
                    }
                }
            }
        }

        return reachable[n - 1];
    }
}