class Solution {
    private Map<Integer, Integer> map;
    private Random random;
    private int size;

    public Solution(int n, int[] blacklist) {
        map = new HashMap<>();
        random = new Random();
        size = n - blacklist.length;

        Set<Integer> blackSet = new HashSet<>();
        for (int num : blacklist) {
            blackSet.add(num);
        }

        int last = n - 1;
        for (int num : blacklist) {
            if (num < size) {
                while (blackSet.contains(last)) {
                    last--;
                }
                map.put(num, last);
                last--;
            }
        }
    }

    public int pick() {
        int num = random.nextInt(size);
        return map.getOrDefault(num, num);
    }
}