class NeighborSumService {
    private Map<Integer, List<Integer>> graph;
    private int[] values;

    public NeighborSumService(int[] nums) {
        graph = new HashMap<>();
        values = nums;
        for (int i = 0; i < nums.length; i++) {
            graph.put(i, new ArrayList<>());
            if (i > 0) graph.get(i).add(i - 1);
            if (i < nums.length - 1) graph.get(i).add(i + 1);
        }
    }

    public void update(int index, int val) {
        values[index] = val;
    }

    public int sum(int index) {
        int sum = 0;
        for (int neighbor : graph.get(index)) {
            sum += values[neighbor];
        }
        return sum;
    }
}