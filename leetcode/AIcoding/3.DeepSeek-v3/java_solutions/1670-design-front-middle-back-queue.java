class FrontMiddleBackQueue {
    private LinkedList<Integer> list;

    public FrontMiddleBackQueue() {
        list = new LinkedList<>();
    }

    public void pushFront(int val) {
        list.addFirst(val);
    }

    public void pushMiddle(int val) {
        int mid = list.size() / 2;
        list.add(mid, val);
    }

    public void pushBack(int val) {
        list.addLast(val);
    }

    public int popFront() {
        if (list.isEmpty()) return -1;
        return list.removeFirst();
    }

    public int popMiddle() {
        if (list.isEmpty()) return -1;
        int mid = (list.size() - 1) / 2;
        return list.remove(mid);
    }

    public int popBack() {
        if (list.isEmpty()) return -1;
        return list.removeLast();
    }
}