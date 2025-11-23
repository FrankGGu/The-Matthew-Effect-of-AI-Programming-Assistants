public class Solution {
    public int findCenter(int[][] edges) {
        int[] firstEdge = edges[0];
        int[] secondEdge = edges[1];

        if (firstEdge[0] == secondEdge[0] || firstEdge[0] == secondEdge[1]) {
            return firstEdge[0];
        } else {
            return firstEdge[1];
        }
    }
}