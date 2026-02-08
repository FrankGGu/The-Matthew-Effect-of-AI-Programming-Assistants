class Solution {
    public int[] maxDepthAfterSplit(String seq) {
        int[] ans = new int[seq.length()];
        int depthA = 0, depthB = 0;
        for (int i = 0; i < seq.length(); i++) {
            if (seq.charAt(i) == '(') {
                if (depthA < depthB) {
                    ans[i] = 0;
                    depthA++;
                } else {
                    ans[i] = 1;
                    depthB++;
                }
            } else {
                if (depthA > depthB) {
                    ans[i] = 0;
                    depthA--;
                } else {
                    ans[i] = 1;
                    depthB--;
                }
            }
        }
        return ans;
    }
}