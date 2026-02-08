class MajorityChecker {
    private int[] arr;
    private Map<Integer, List<Integer>> map;

    public MajorityChecker(int[] arr) {
        this.arr = arr;
        this.map = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            int num = arr[i];
            if (!map.containsKey(num)) {
                map.put(num, new ArrayList<>());
            }
            map.get(num).add(i);
        }
    }

    public int query(int left, int right, int threshold) {
        Random rand = new Random();
        for (int i = 0; i < 20; i++) {
            int candidate = arr[left + rand.nextInt(right - left + 1)];
            List<Integer> list = map.get(candidate);
            int leftIdx = lowerBound(list, left);
            int rightIdx = upperBound(list, right);
            int count = rightIdx - leftIdx;
            if (count >= threshold) {
                return candidate;
            }
        }
        return -1;
    }

    private int lowerBound(List<Integer> list, int target) {
        int left = 0, right = list.size();
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (list.get(mid) < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    private int upperBound(List<Integer> list, int target) {
        int left = 0, right = list.size();
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (list.get(mid) <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}