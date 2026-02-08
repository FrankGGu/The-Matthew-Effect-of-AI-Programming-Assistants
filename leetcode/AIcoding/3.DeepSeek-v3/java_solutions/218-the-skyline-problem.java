class Solution {
    public List<List<Integer>> getSkyline(int[][] buildings) {
        List<List<Integer>> result = new ArrayList<>();
        List<int[]> heights = new ArrayList<>();

        for (int[] building : buildings) {
            heights.add(new int[]{building[0], -building[2]});
            heights.add(new int[]{building[1], building[2]});
        }

        Collections.sort(heights, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        maxHeap.offer(0);
        int prevMax = 0;

        for (int[] height : heights) {
            if (height[1] < 0) {
                maxHeap.offer(-height[1]);
            } else {
                maxHeap.remove(height[1]);
            }

            int currentMax = maxHeap.peek();
            if (currentMax != prevMax) {
                result.add(Arrays.asList(height[0], currentMax));
                prevMax = currentMax;
            }
        }

        return result;
    }
}