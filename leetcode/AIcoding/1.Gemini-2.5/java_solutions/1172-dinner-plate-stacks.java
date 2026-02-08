import java.util.ArrayList;
import java.util.Stack;
import java.util.TreeSet;

class DinnerPlates {

    private int capacity;
    private ArrayList<Stack<Integer>> stacks;
    private TreeSet<Integer> nonFullStacks;
    private TreeSet<Integer> nonEmptyStacks;

    public DinnerPlates(int capacity) {
        this.capacity = capacity;
        this.stacks = new ArrayList<>();
        this.nonFullStacks = new TreeSet<>();
        this.nonEmptyStacks = new TreeSet<>();
    }

    public void push(int val) {
        int targetStackIndex;

        if (nonFullStacks.isEmpty()) {
            targetStackIndex = stacks.size();
            stacks.add(new Stack<>());
            nonFullStacks.add(targetStackIndex);
        } else {
            targetStackIndex = nonFullStacks.first();
        }

        stacks.get(targetStackIndex).push(val);
        nonEmptyStacks.add(targetStackIndex);

        if (stacks.get(targetStackIndex).size() == capacity) {
            nonFullStacks.remove(targetStackIndex);
        }
    }

    public int pop() {
        if (nonEmptyStacks.isEmpty()) {
            return -1;
        }

        int targetStackIndex = nonEmptyStacks.last();

        int val = stacks.get(targetStackIndex).pop();

        nonFullStacks.add(targetStackIndex);

        if (stacks.get(targetStackIndex).isEmpty()) {
            nonEmptyStacks.remove(targetStackIndex);
        }

        return val;
    }

    public int popAtStack(int index) {
        if (index < 0 || index >= stacks.size() || stacks.get(index).isEmpty()) {
            return -1;
        }

        int val = stacks.get(index).pop();

        nonFullStacks.add(index);

        if (stacks.get(index).isEmpty()) {
            nonEmptyStacks.remove(index);
        }

        return val;
    }
}