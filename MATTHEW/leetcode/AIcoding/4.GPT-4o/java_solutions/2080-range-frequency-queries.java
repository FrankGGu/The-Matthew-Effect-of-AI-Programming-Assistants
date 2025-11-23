class RangeFreqQuery {
    private Map<Integer, List<Integer>> indexMap;

    public RangeFreqQuery(int[] arr) {
        indexMap = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            indexMap.putIfAbsent(arr[i], new ArrayList<>());
            indexMap.get(arr[i]).add(i);
        }
    }

    public int query(int left, int right, int value) {
        if (!indexMap.containsKey(value)) {
            return 0;
        }
        List<Integer> indices = indexMap.get(value);
        int start = Collections.binarySearch(indices, left);
        int end = Collections.binarySearch(indices, right);
        if (start < 0) {
            start = -start - 1;
        } else {
            while (start > 0 && indices.get(start - 1) >= left) {
                start--;
            }
        }
        if (end < 0) {
            end = -end - 1;
        }
        return end - start;
    }
}