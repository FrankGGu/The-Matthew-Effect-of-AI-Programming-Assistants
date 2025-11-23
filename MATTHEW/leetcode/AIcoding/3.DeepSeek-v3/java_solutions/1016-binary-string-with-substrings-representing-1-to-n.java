class Solution {
    public boolean queryString(String S, int N) {
        for (int i = 1; i <= N; i++) {
            String binary = Integer.toBinaryString(i);
            if (!S.contains(binary)) {
                return false;
            }
        }
        return true;
    }
}