import java.util.ArrayList;
import java.util.List;
import java.util.PriorityQueue;
import java.util.TreeSet;

class DinnerPlates {

    private int capacity;
    private List<List<Integer>> stacks;
    private TreeSet<Integer> available;
    private PriorityQueue<Integer> full;

    public DinnerPlates(int capacity) {
        this.capacity = capacity;
        this.stacks = new ArrayList<>();
        this.available = new TreeSet<>();
        this.full = new PriorityQueue<>();
    }

    public void push(int val) {
        if (available.isEmpty()) {
            int index = stacks.size();
            stacks.add(new ArrayList<>());
            stacks.get(index).add(val);
            if (stacks.get(index).size() < capacity) {
                available.add(index);
            } else if (stacks.get(index).size() == capacity){
                full.offer(index);
            }
        } else {
            int index = available.first();
            stacks.get(index).add(val);
            if (stacks.get(index).size() == capacity) {
                available.remove(index);
                full.offer(index);
            }
        }
    }

    public int pop() {
        while (!stacks.isEmpty() && stacks.get(stacks.size() - 1).isEmpty()) {
            stacks.remove(stacks.size() - 1);
        }

        if (stacks.isEmpty()) {
            return -1;
        }

        int index = stacks.size() - 1;
        int val = stacks.get(index).remove(stacks.get(index).size() - 1);
        if (stacks.get(index).isEmpty()) {
            if (available.contains(index)) {
                available.remove(index);
            }
            if (full.contains(index)){
                full.remove(index);
            }
        } else {
            available.add(index);
            if (full.contains(index)){
                full.remove(index);
            }
        }
        return val;
    }

    public int popAtStack(int index) {
        if (index >= stacks.size() || stacks.get(index).isEmpty()) {
            return -1;
        }

        int val = stacks.get(index).remove(stacks.get(index).size() - 1);
        available.add(index);
        if (full.contains(index)){
            full.remove(index);
        }
        return val;
    }
}