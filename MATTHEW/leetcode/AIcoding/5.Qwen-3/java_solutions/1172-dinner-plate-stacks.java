public class Solution {

import java.util.*;

public class DinnerPlateStacks {
    private int capacity;
    private TreeSet<Integer> available;
    private List<Stack<Integer>> stacks;

    public DinnerPlateStacks(int capacity) {
        this.capacity = capacity;
        this.available = new TreeSet<>();
        this.stacks = new ArrayList<>();
    }

    public void push(int val) {
        if (available.isEmpty()) {
            stacks.add(new Stack<>());
            available.add(stacks.size() - 1);
        }
        int index = available.pollFirst();
        stacks.get(index).push(val);
        if (stacks.get(index).size() == capacity) {
            available.remove(index);
        }
    }

    public int pop() {
        if (stacks.isEmpty()) {
            return -1;
        }
        int index = stacks.size() - 1;
        int val = stacks.get(index).pop();
        if (stacks.get(index).isEmpty()) {
            stacks.remove(index);
            available.remove(index);
        } else {
            available.add(index);
        }
        return val;
    }

    public int popAt(int index) {
        if (index < 0 || index >= stacks.size()) {
            return -1;
        }
        Stack<Integer> stack = stacks.get(index);
        if (stack.isEmpty()) {
            return -1;
        }
        int val = stack.pop();
        available.add(index);
        return val;
    }

    public int popAtStack(int index) {
        return popAt(index);
    }
}
}