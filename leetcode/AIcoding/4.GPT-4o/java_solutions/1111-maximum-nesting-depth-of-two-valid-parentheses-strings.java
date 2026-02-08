public class Solution {
    public int[] maxDepthAfterSplit(String seq) {
        int[] result = new int[seq.length()];
        int depth = 0;

        for (int i = 0; i < seq.length(); i++) {
            depth += seq.charAt(i) == '(' ? 1 : -1;
            result[i] = (depth % 2 == 0) ? 0 : 1;
        }

        return result;
    }
}