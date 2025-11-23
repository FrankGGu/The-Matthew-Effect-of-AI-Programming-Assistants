class Solution {
    public int countColors(int[] balls) {
        Set<Integer> colors = new HashSet<>();
        for (int ball : balls) {
            colors.add(ball);
        }
        return colors.size();
    }
}