class DinnerPlates {
    private List<Stack<Integer>> stacks;
    private PriorityQueue<Integer> leftNotFull;
    private int capacity;

    public DinnerPlates(int capacity) {
        this.stacks = new ArrayList<>();
        this.leftNotFull = new PriorityQueue<>();
        this.capacity = capacity;
    }

    public void push(int val) {
        if (leftNotFull.isEmpty()) {
            stacks.add(new Stack<>());
            leftNotFull.add(stacks.size() - 1);
        }
        int index = leftNotFull.peek();
        stacks.get(index).push(val);
        if (stacks.get(index).size() == capacity) {
            leftNotFull.poll();
        }
    }

    public int pop() {
        while (!stacks.isEmpty() && stacks.get(stacks.size() - 1).isEmpty()) {
            stacks.remove(stacks.size() - 1);
        }
        if (stacks.isEmpty()) {
            return -1;
        }
        return popAtStack(stacks.size() - 1);
    }

    public int popAtStack(int index) {
        if (index < 0 || index >= stacks.size() || stacks.get(index).isEmpty()) {
            return -1;
        }
        int val = stacks.get(index).pop();
        leftNotFull.add(index);
        return val;
    }
}