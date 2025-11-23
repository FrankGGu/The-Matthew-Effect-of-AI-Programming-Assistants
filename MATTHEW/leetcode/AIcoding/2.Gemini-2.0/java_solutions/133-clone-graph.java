import java.util.*;

public class Solution {
    public Node cloneGraph(Node node) {
        if (node == null) return null;

        Map<Node, Node> map = new HashMap<>();
        Queue<Node> queue = new LinkedList<>();

        Node clonedNode = new Node(node.val);
        map.put(node, clonedNode);
        queue.offer(node);

        while (!queue.isEmpty()) {
            Node curr = queue.poll();
            Node clonedCurr = map.get(curr);

            for (Node neighbor : curr.neighbors) {
                if (!map.containsKey(neighbor)) {
                    Node clonedNeighbor = new Node(neighbor.val);
                    map.put(neighbor, clonedNeighbor);
                    queue.offer(neighbor);
                }
                clonedCurr.neighbors.add(map.get(neighbor));
            }
        }

        return clonedNode;
    }
}