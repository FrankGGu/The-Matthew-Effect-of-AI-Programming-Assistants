public class Solution {



import java.util.*;

public class Solution {
    public List<Integer> preorder(Node root) {
        List<Integer> result = new ArrayList<>();
        if (root == null) {
            return result;
        }
        Stack<Node> stack = new Stack<>();
        stack.push(root);
        while (!stack.isEmpty()) {
            Node node = stack.pop();
            result.add(node.val);
            Collections.reverse(node.children);
            for (Node child : node.children) {
                stack.push(child);
            }
        }
        return result;
    }
}
}