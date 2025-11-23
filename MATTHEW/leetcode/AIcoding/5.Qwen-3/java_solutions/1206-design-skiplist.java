public class Solution {

import java.util.*;

class Skiplist {
    private static class Node {
        int val;
        Node[] next;

        Node(int val, int level) {
            this.val = val;
            this.next = new Node[level];
        }
    }

    private final int MAX_LEVEL = 16;
    private int level;
    private Node head;

    public Skiplist() {
        this.level = 0;
        this.head = new Node(-1, MAX_LEVEL);
    }

    public boolean search(int target) {
        Node curr = head;
        for (int i = level - 1; i >= 0; i--) {
            while (curr.next[i] != null && curr.next[i].val < target) {
                curr = curr.next[i];
            }
        }
        return curr.next[0] != null && curr.next[0].val == target;
    }

    public void add(int num) {
        Node[] update = new Node[MAX_LEVEL];
        Arrays.fill(update, head);
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
        Node node = new Node(num, newLevel);
        for (int i = 0; i < newLevel; i++) {
            node.next[i] = update[i].next[i];
            update[i].next[i] = node;
        }
    }

    public boolean erase(int num) {
        Node[] update = new Node[MAX_LEVEL];
        Arrays.fill(update, head);
        Node curr = head;
        for (int i = level - 1; i >= 0; i--) {
            while (curr.next[i] != null && curr.next[i].val < num) {
                curr = curr.next[i];
            }
            update[i] = curr;
        }
        Node node = update[0].next[0];
        if (node == null || node.val != num) {
            return false;
        }
        for (int i = 0; i < level; i++) {
            if (update[i].next[i] != node) {
                break;
            }
            update[i].next[i] = node.next[i];
        }
        while (level > 0 && head.next[level - 1] == null) {
            level--;
        }
        return true;
    }

    private int randomLevel() {
        int level = 1;
        while (Math.random() < 0.5 && level < MAX_LEVEL) {
            level++;
        }
        return level;
    }
}
}