class MKAverage {

    private int m;
    private int k;
    private int[] stream;
    private int size;
    private long sum;
    private java.util.PriorityQueue<Integer> minHeap;
    private java.util.PriorityQueue<Integer> maxHeap;
    private java.util.PriorityQueue<Integer> midHeap;

    public MKAverage(int m, int k) {
        this.m = m;
        this.k = k;
        this.stream = new int[100000];
        this.size = 0;
        this.sum = 0;
        this.minHeap = new java.util.PriorityQueue<>();
        this.maxHeap = new java.util.PriorityQueue<>((a, b) -> b - a);
        this.midHeap = new java.util.PriorityQueue<>();
    }

    public void addElement(int num) {
        stream[size++] = num;
    }

    public int calculateMKAverage() {
        if (size < m) {
            return -1;
        }

        minHeap.clear();
        maxHeap.clear();
        midHeap.clear();
        sum = 0;

        for (int i = 0; i < m; i++) {
            maxHeap.offer(stream[size - m + i]);
        }

        for (int i = 0; i < k; i++) {
            midHeap.offer(maxHeap.poll());
        }

        for (int i = 0; i < m - k; i++) {
            minHeap.offer(maxHeap.poll());
        }

        while (!midHeap.isEmpty()) {
            sum += midHeap.poll();
        }

        return (int) (sum / (m - 2 * k));
    }
}