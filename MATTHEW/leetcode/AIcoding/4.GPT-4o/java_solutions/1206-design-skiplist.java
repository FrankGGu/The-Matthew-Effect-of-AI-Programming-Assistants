import java.util.Random;

class Skiplist {
    private class Node {
        int val;
        Node[] next;
        Node(int val, int level) {
            this.val = val;
            this.next = new Node[level + 1];
        }
    }

    private Node head;
    private int maxLevel;
    private int levelCount;
    private Random random;

    public Skiplist() {
        head = new Node(-1, 32);
        maxLevel = 32;
        levelCount = 0;
        random = new Random();
    }

    public boolean search(int target) {
        Node current = head;
        for (int i = levelCount; i >= 0; i--) {
            while (current.next[i] != null && current.next[i].val < target) {
                current = current.next[i];
            }
        }
        current = current.next[0];
        return current != null && current.val == target;
    }

    public void add(int num) {
        Node current = head;
        Node[] update = new Node[maxLevel + 1];
        for (int i = levelCount; i >= 0; i--) {
            while (current.next[i] != null && current.next[i].val < num) {
                current = current.next[i];
            }
            update[i] = current;
        }
        current = current.next[0];
        if (current == null || current.val != num) {
            int level = randomLevel();
            if (level > levelCount) {
                for (int i = levelCount + 1; i <= level; i++) {
                    update[i] = head;
                }
                levelCount = level;
            }
            Node newNode = new Node(num, level);
            for (int i = 0; i <= level; i++) {
                newNode.next[i] = update[i].next[i];
                update[i].next[i] = newNode;
            }
        }
    }

    public boolean erase(int num) {
        Node current = head;
        Node[] update = new Node[maxLevel + 1];
        for (int i = levelCount; i >= 0; i--) {
            while (current.next[i] != null && current.next[i].val < num) {
                current = current.next[i];
            }
            update[i] = current;
        }
        current = current.next[0];
        if (current == null || current.val != num) {
            return false;
        } else {
            for (int i = 0; i <= levelCount; i++) {
                if (update[i].next[i] != current) {
                    break;
                }
                update[i].next[i] = current.next[i];
            }
            while (levelCount > 0 && head.next[levelCount] == null) {
                levelCount--;
            }
            return true;
        }
    }

    private int randomLevel() {
        int level = 0;
        while (level < maxLevel && random.nextInt(2) == 1) {
            level++;
        }
        return level;
    }
}