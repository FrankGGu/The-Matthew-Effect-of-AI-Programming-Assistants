class Solution {
    public int[] maxDepthAfterSplit(String seq) {
        int[] ans = new int[seq.length()];
        int level = 0; 
        for (int i = 0; i < seq.length(); i++) {
            char c = seq.charAt(i);
            if (c == '(') {
                level++;
                ans[i] = (level - 1) % 2;
            } else { // c == ')'
                ans[i] = (level - 1) % 2;
                level--;
            }
        }
        return ans;
    }
}