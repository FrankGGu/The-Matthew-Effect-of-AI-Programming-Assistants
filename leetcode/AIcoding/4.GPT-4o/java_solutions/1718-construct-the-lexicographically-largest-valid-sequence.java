class Solution {
    public String largestValidSequence(int n) {
        StringBuilder sb = new StringBuilder();
        for (int i = n; i > 0; i--) {
            sb.append(i);
        }
        return sb.toString();
    }
}