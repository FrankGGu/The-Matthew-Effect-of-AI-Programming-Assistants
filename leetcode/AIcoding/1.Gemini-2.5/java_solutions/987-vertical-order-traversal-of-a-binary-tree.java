import java.util.*;

class Solution {
    class NodeInfo {
        int row;
        int val;

        NodeInfo(int row, int val) {
            this.row = row;
            this.val = val;
        }
    }

    class QueueElement {
        TreeNode node;
        int col;
        int row;

        QueueElement(TreeNode node, int col, int row) {
            this.node = node;
            this.col = col;
            this.row = row;
        }
    }

    public List<List<Integer>> verticalTraversal(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) {
            return result;
        }

        TreeMap<Integer, List<NodeInfo>> columnMap = new TreeMap<>();
        Queue<QueueElement> queue = new LinkedList<>();
        queue.offer(new QueueElement(root, 0, 0));

        while (!queue.isEmpty()) {
            QueueElement current = queue.poll();
            TreeNode node = current.node;
            int col = current.col;
            int row = current.row;

            columnMap.computeIfAbsent(col, k -> new ArrayList<>()).add(new new NodeInfo(row, node.val));

            if (node.left != null) {
                queue.offer(new QueueElement(node.left, col - 1, row + 1));
            }

            if (node.right != null) {
                queue.offer(new QueueElement(node.right, col + 1, row + 1));
            }
        }

        for (int col : columnMap.keySet()) {
            List<NodeInfo> nodesInColumn = columnMap.get(col);

            Collections.sort(nodesInColumn, (a, b) -> {
                if (a.row != b.row) {
                    return Integer.compare(a.row, b.row);
                } else {
                    return Integer.compare(a.val, b.val);
                }
            });

            List<Integer> currentColumnValues = new ArrayList<>();
            for (NodeInfo nodeInfo : nodesInColumn) {
                currentColumnValues.add(nodeInfo.val);
            }
            result.add(currentColumnValues);
        }

        return result;
    }
}