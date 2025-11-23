class SORTracker {

    private static class Location {
        String name;
        int score;

        public Location(String name, int score) {
            this.name = name;
            this.score = score;
        }
    }

    private PriorityQueue<Location> minHeap;
    private PriorityQueue<Location> maxHeap;
    private int queryCount;

    public SORTracker() {
        minHeap = new PriorityQueue<>((a, b) -> {
            if (a.score != b.score) {
                return Integer.compare(a.score, b.score);
            } else {
                return b.name.compareTo(a.name);
            }
        });

        maxHeap = new PriorityQueue<>((a, b) -> {
            if (a.score != b.score) {
                return Integer.compare(b.score, a.score);
            } else {
                return a.name.compareTo(b.name);
            }
        });

        queryCount = 0;
    }

    public void add(String name, int score) {
        Location loc = new Location(name, score);
        if (minHeap.size() < queryCount) {
            minHeap.offer(loc);
        } else {
            maxHeap.offer(loc);
            if (!maxHeap.isEmpty()) {
                minHeap.offer(maxHeap.poll());
            }
        }
    }

    public String get() {
        queryCount++;
        String result = minHeap.peek().name;
        if (!maxHeap.isEmpty()) {
            minHeap.offer(maxHeap.poll());
        }
        return result;
    }
}