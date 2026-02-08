public class Solution {

class Solution {
    public int maxDepthAfterSplit(String seq) {
        int depth = 0;
        int maxDepth = 0;
        for (int i = 0; i < seq.length(); i++) {
            if (seq.charAt(i) == '(') {
                depth++;
                maxDepth = Math.max(maxDepth, depth);
            } else {
                depth--;
            }
        }
        return maxDepth;
    }
}
}