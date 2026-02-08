class Solution {
    public List<Integer> leftmostBuildingQueries(int[] heights, int[][] queries) {
        List<Integer> result = new ArrayList<>();
        for (int[] query : queries) {
            int a = query[0];
            int b = query[1];
            if (a == b) {
                result.add(a);
                continue;
            }
            if (a > b) {
                int temp = a;
                a = b;
                b = temp;
            }
            if (heights[a] < heights[b]) {
                result.add(b);
                continue;
            }
            int idx = -1;
            for (int i = b + 1; i < heights.length; i++) {
                if (heights[i] > heights[a] && heights[i] > heights[b]) {
                    idx = i;
                    break;
                }
            }
            result.add(idx);
        }
        return result;
    }
}