public class Solution {

import java.util.*;

public class Solution {
    private int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    public int largestIsland(TreeNode root) {
        if (root == null) return 0;

        Map<Integer, Integer> areaMap = new HashMap<>();
        int area = dfs(root, areaMap);

        int maxArea = area;
        dfs2(root, areaMap, maxArea);

        return maxArea;
    }

    private int dfs(TreeNode node, Map<Integer, Integer> areaMap) {
        if (node == null) return 0;

        int left = dfs(node.left, areaMap);
        int right = dfs(node.right, areaMap);

        int area = left + right + 1;
        areaMap.put(node.val, area);

        return area;
    }

    private void dfs2(TreeNode node, Map<Integer, Integer> areaMap, int maxArea) {
        if (node == null) return;

        int total = 1;
        Set<Integer> visited = new HashSet<>();

        for (int[] dir : directions) {
            int x = node.val + dir[0];
            int y = node.val + dir[1];

            if (areaMap.containsKey(x)) {
                total += areaMap.get(x);
                visited.add(x);
            }
            if (areaMap.containsKey(y)) {
                total += areaMap.get(y);
                visited.add(y);
            }
        }

        maxArea = Math.max(maxArea, total);

        dfs2(node.left, areaMap, maxArea);
        dfs2(node.right, areaMap, maxArea);
    }
}
}