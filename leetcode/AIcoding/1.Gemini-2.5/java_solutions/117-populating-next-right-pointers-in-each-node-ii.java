class Solution {
    public Node connect(Node root) {
        if (root == null) {
            return null;
        }

        Node currentLevelHead = root;

        while (currentLevelHead != null) {
            Node dummyHeadForNextLevel = new Node(); // A dummy node to simplify linking the next level
            Node pointerForNextLevel = dummyHeadForNextLevel;

            Node current = currentLevelHead;
            while (current != null) {
                if (current.left != null) {
                    pointerForNextLevel.next = current.left;
                    pointerForNextLevel = pointerForNextLevel.next;
                }
                if (current.right != null) {
                    pointerForNextLevel.next = current.right;
                    pointerForNextLevel = pointerForNextLevel.next;
                }
                current = current.next; // Move to the next node in the current level
            }

            // Move to the head of the next level
            currentLevelHead = dummyHeadForNextLevel.next;
        }

        return root;
    }
}