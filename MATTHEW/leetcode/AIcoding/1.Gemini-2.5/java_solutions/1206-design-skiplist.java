import java.util.Random;

class Skiplist {

    private static final int MAX_LEVEL = 16;
    private static final double P = 0.5;

    private Node head;
    private int level;
    private Random rand;

    private static class Node {
        int val;
        Node[] next;

        public Node(int val, int level) {
            this.val = val;
            this.next = new Node[level];
        }
    }

    public Skiplist() {
        head = new Node(-1, MAX_LEVEL);
        level = 0;
        rand = new Random();
    }

    private int randomLevel() {
        int lvl = 1;
        while (rand.nextDouble() < P && lvl < MAX_LEVEL) {
            lvl++;
        }
        return lvl;
    }

    public boolean search(int target) {
        Node curr = head;
        for (int i = level - 1; i >= 0; i--) {
            while (curr.next[i] != null && curr.next[i].val < target) {
                curr = curr.next[i];
            }
        }
        curr = curr.next[0];
        return curr != null && curr.val == target;
    }

    public void add(int num) {
        Node[] update = new Node[MAX_LEVEL];
        Node curr = head;

        for (int i = level - 1; i >= 0; i--) {
            while (curr.next[i] != null && curr.next[i].val < num) {
                curr = curr.next[i];
            }
            update[i] = curr;
        }

        int newLevel = randomLevel();

        if (newLevel > level) {
            for (int i = level; i < newLevel; i++) {
                update[i] = head;
            }
            level = newLevel;
        }

        Node newNode = new Node(num, newLevel);

        for (int i = 0; i < newLevel; i++) {
            newNode.next[i] = update[i].next[i];
            update[i].next[i] = newNode;
        }
    }

    public boolean erase(int num) {
        Node[] update = new Node[MAX_LEVEL];
        Node curr = head;

        for (int i = level - 1; i >= 0; i--) {
            while (curr.next[i] != null && curr.next[i].val < num) {
                curr = curr.next[i];
            }
            update[i] = curr;
        }

        curr = curr.next[0];
        if (curr == null || curr.val != num) {
            return false;
        }

        for (int i = 0; i < level; i++) {
            if (update[i].next[i] == curr) {
                update[i].next[i] = curr.next[i];
            }
        }

        while (level > 0 && head.next[level - 1] == null) {
            level--;
        }

        return true;
    }
}