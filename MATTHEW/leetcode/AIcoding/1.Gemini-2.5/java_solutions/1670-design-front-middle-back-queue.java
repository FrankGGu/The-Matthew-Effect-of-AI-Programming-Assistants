import java.util.LinkedList;

class FrontMiddleBackQueue {

    private LinkedList<Integer> left;
    private LinkedList<Integer> right;

    public FrontMiddleBackQueue() {
        left = new LinkedList<>();
        right = new LinkedList<>();
    }

    private void balance() {
        // Ensure left.size() is not less than right.size()
        while (left.size() < right.size()) {
            left.addLast(right.removeFirst());
        }
        // Ensure left.size() is not greater than right.size() + 1
        while (left.size() > right.size() + 1) {
            right.addFirst(left.removeLast());
        }
    }

    public void pushFront(int val) {
        left.addFirst(val);
        balance();
    }

    public void pushMiddle(int val) {
        left.addLast(val);
        balance();
    }

    public void pushBack(int val) {
        right.addLast(val);
        balance();
    }

    public int popFront() {
        if (left.isEmpty() && right.isEmpty()) {
            return -1;
        }
        balance(); // Ensure left is not empty if right has elements
        int val = left.removeFirst();
        balance(); // Rebalance after removal
        return val;
    }

    public int popMiddle() {
        if (left.isEmpty() && right.isEmpty()) {
            return -1;
        }
        balance(); // Ensure left has the middle element, potentially moving from right
        int val = left.removeLast();
        balance(); // Rebalance after removal
        return val;
    }

    public int popBack() {
        if (left.isEmpty() && right.isEmpty()) {
            return -1;
        }
        balance(); // Ensure correct balance before deciding where to pop from
        int val;
        if (right.isEmpty()) { // If right is empty, the last element is in left
            val = left.removeLast();
        } else {
            val = right.removeLast();
        }
        balance(); // Rebalance after removal
        return val;
    }
}