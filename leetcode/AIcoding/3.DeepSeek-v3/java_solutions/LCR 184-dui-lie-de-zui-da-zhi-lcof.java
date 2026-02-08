class Checkout {
    private Map<Integer, Integer> itemCount;
    private Queue<Integer> queue;

    public Checkout() {
        itemCount = new HashMap<>();
        queue = new LinkedList<>();
    }

    public int get_max() {
        if (queue.isEmpty()) {
            return -1;
        }
        int max = Collections.max(itemCount.keySet());
        return max;
    }

    public void add(int value) {
        itemCount.put(value, itemCount.getOrDefault(value, 0) + 1);
        queue.offer(value);
    }

    public int remove() {
        if (queue.isEmpty()) {
            return -1;
        }
        int value = queue.poll();
        int count = itemCount.get(value);
        if (count == 1) {
            itemCount.remove(value);
        } else {
            itemCount.put(value, count - 1);
        }
        return value;
    }
}