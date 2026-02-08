import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

class DinnerPlateStacks {
    private List<Stack<Integer>> stacks;
    private int capacity;

    public DinnerPlateStacks(int capacity) {
        this.stacks = new ArrayList<>();
        this.capacity = capacity;
    }

    public void push(int val) {
        if (stacks.isEmpty() || stacks.get(stacks.size() - 1).size() == capacity) {
            stacks.add(new Stack<>());
        }
        stacks.get(stacks.size() - 1).push(val);
    }

    public int pop() {
        while (!stacks.isEmpty() && stacks.get(stacks.size() - 1).isEmpty()) {
            stacks.remove(stacks.size() - 1);
        }
        if (stacks.isEmpty()) {
            return -1;
        }
        return stacks.get(stacks.size() - 1).pop();
    }

    public int popAtStack(int index) {
        if (index < 0 || index >= stacks.size() || stacks.get(index).isEmpty()) {
            return -1;
        }
        int value = stacks.get(index).pop();
        while (index < stacks.size() - 1 && stacks.get(index).isEmpty()) {
            stacks.remove(index);
        }
        return value;
    }
}