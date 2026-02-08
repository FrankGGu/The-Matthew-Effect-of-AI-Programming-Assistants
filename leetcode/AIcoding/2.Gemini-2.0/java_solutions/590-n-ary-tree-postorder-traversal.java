import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class NAryTreePostorderTraversal {

    class Node {
        public int val;
        public List<Node> children;

        public Node() {}

        public Node(int _val) {
            val = _val;
        }

        public Node(int _val, List<Node> _children) {
            val = _val;
            children = _children;
        }
    }

    public List<Integer> postorder(Node root) {
        List<Integer> result = new ArrayList<>();
        if (root == null) {
            return result;
        }

        Stack<Node> stack = new Stack<>();
        stack.push(root);

        Stack<Integer> output = new Stack<>();

        while (!stack.isEmpty()) {
            Node node = stack.pop();
            output.push(node.val);

            if (node.children != null) {
                for (Node child : node.children) {
                    stack.push(child);
                }
            }
        }

        while (!output.isEmpty()) {
            result.add(output.pop());
        }

        return result;
    }
}