class Solution {
    public Node insert(Node head, int insertVal) {
        if (head == null) {
            Node newNode = new Node(insertVal);
            newNode.next = newNode;
            return newNode;
        }

        Node curr = head;
        boolean inserted = false;

        do {
            if (curr.val <= insertVal && insertVal <= curr.next.val) {
                Node newNode = new Node(insertVal, curr.next);
                curr.next = newNode;
                inserted = true;
                break;
            } else if (curr.val > curr.next.val) { 
                if (insertVal >= curr.val || insertVal <= curr.next.val) {
                    Node newNode = new Node(insertVal, curr.next);
                    curr.next = newNode;
                    inserted = true;
                    break;
                }
            }
            curr = curr.next;
        } while (curr != head);

        if (!inserted) {
            Node newNode = new Node(insertVal, curr.next);
            curr.next = newNode;
        }

        return head;
    }
}