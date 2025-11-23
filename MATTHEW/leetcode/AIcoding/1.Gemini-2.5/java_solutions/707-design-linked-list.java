class MyLinkedList {

    private class Node {
        int val;
        Node next;
        Node(int x) {
            val = x;
        }
    }

    private Node head; // Dummy head node
    private int size;

    public MyLinkedList() {
        head = new Node(0); // Initialize with a dummy head node
        size = 0;
    }

    public int get(int index) {
        if (index < 0 || index >= size) {
            return -1;
        }
        Node curr = head.next; // Start from the first actual node
        for (int i = 0; i < index; i++) {
            curr = curr.next;
        }
        return curr.val;
    }

    public void addAtHead(int val) {
        addAtIndex(0, val);
    }

    public void addAtTail(int val) {
        addAtIndex(size, val);
    }

    public void addAtIndex(int index, int val) {
        if (index < 0 || index > size) {
            return;
        }

        Node prev = head; // Start traversal from the dummy head
        for (int i = 0; i < index; i++) {
            prev = prev.next;
        }

        Node newNode = new Node(val);
        newNode.next = prev.next;
        prev.next = newNode;
        size++;
    }

    public void deleteAtIndex(int index) {
        if (index < 0 || index >= size) {
            return;
        }

        Node prev = head; // Start traversal from the dummy head
        for (int i = 0; i < index; i++) {
            prev = prev.next;
        }

        prev.next = prev.next.next; // Skip the node to be deleted
        size--;
    }
}