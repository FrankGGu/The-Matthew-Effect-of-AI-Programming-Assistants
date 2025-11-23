class Solution {
    public List<Integer> findStableMountains(int[] heights) {
        List<Integer> result = new ArrayList<>();
        for (int i = 1; i < heights.length - 1; i++) {
            if (heights[i] > heights[i - 1] && heights[i] > heights[i + 1]) {
                result.add(i);
            }
        }
        return result;
    }
}