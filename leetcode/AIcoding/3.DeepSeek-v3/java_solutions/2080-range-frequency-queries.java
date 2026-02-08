class RangeFreqQuery {
    private Map<Integer, List<Integer>> map;

    public RangeFreqQuery(int[] arr) {
        map = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            int num = arr[i];
            map.putIfAbsent(num, new ArrayList<>());
            map.get(num).add(i);
        }
    }

    public int query(int left, int right, int value) {
        if (!map.containsKey(value)) {
            return 0;
        }
        List<Integer> indices = map.get(value);
        int leftIdx = binarySearchLeft(indices, left);
        int rightIdx = binarySearchRight(indices, right);
        return rightIdx - leftIdx + 1;
    }

    private int binarySearchLeft(List<Integer> indices, int target) {
        int left = 0;
        int right = indices.size() - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (indices.get(mid) < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }

    private int binarySearchRight(List<Integer> indices, int target) {
        int left = 0;
        int right = indices.size() - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (indices.get(mid) <= target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return right;
    }
}