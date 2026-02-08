public class Solution {

class Solution {
    public Node intersect(Node a, Node b) {
        if (a.isLeaf && b.isLeaf) {
            return new Node(a.val || b.val, true, null, null, null);
        }
        if (a.isLeaf) {
            return a.val ? a : b;
        }
        if (b.isLeaf) {
            return b.val ? b : a;
        }
        Node topLeft = intersect(a.topLeft, b.topLeft);
        Node topRight = intersect(a.topRight, b.topRight);
        Node bottomLeft = intersect(a.bottomLeft, b.bottomLeft);
        Node bottomRight = intersect(a.bottomRight, b.bottomRight);
        if (topLeft.isLeaf && topRight.isLeaf && bottomLeft.isLeaf && bottomRight.isLeaf &&
            topLeft.val == topRight.val && topRight.val == bottomLeft.val && bottomLeft.val == bottomRight.val) {
            return new Node(topLeft.val, true, null, null, null);
        }
        return new Node(false, false, topLeft, topRight, bottomLeft, bottomRight);
    }

    class Node {
        public boolean val;
        public boolean isLeaf;
        public Node topLeft;
        public Node topRight;
        public Node bottomLeft;
        public Node bottomRight;

        public Node() {
            this.val = false;
            this.isLeaf = false;
            this.topLeft = null;
            this.topRight = null;
            this.bottomLeft = null;
            this.bottomRight = null;
        }

        public Node(boolean val, boolean isLeaf) {
            this.val = val;
            this.isLeaf = isLeaf;
            this.topLeft = null;
            this.topRight = null;
            this.bottomLeft = null;
            this.bottomRight = null;
        }

        public Node(boolean val, boolean isLeaf, Node topLeft, Node topRight, Node bottomLeft, Node bottomRight) {
            this.val = val;
            this.isLeaf = isLeaf;
            this.topLeft = topLeft;
            this.topRight = topRight;
            this.bottomLeft = bottomLeft;
            this.bottomRight = bottomRight;
        }
    }
}
}