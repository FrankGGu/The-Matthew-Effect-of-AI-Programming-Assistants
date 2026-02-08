import java.util.*;

class Solution {
    public List<List<Integer>> verticalTraversal(TreeNode root) {
        TreeMap<Integer, List<int[]>> map = new TreeMap<>();
        Queue<Pair> queue = new LinkedList<>();
        queue.offer(new Pair(root, 0, 0));

        while (!queue.isEmpty()) {
            Pair curr = queue.poll();
            TreeNode node = curr.node;
            int col = curr.col;
            int row = curr.row;

            map.computeIfAbsent(col, k -> new ArrayList<>()).add(new int[]{row, node.val});

            if (node.left != null) {
                queue.offer(new Pair(node.left, col - 1, row + 1));
            }
            if (node.right != null) {
                queue.offer(new Pair(node.right, col + 1, row + 1));
            }
        }

        List<List<Integer>> result = new ArrayList<>();
        for (List<int[]> list : map.values()) {
            Collections.sort(list, (a, b) -> {
                if (a[0] != b[0]) {
                    return a[0] - b[0];
                } else {
                    return a[1] - b[1];
                }
            });
            List<Integer> colList = new ArrayList<>();
            for (int[] arr : list) {
                colList.add(arr[1]);
            }
            result.add(colList);
        }

        return result;
    }

    static class Pair {
        TreeNode node;
        int col;
        int row;

        Pair(TreeNode node, int col, int row) {
            this.node = node;
            this.col = col;
            this.row = row;
        }
    }
}