class Solution {
    public boolean isNStraightHand(int[] hand, int groupSize) {
        if (hand.length % groupSize != 0) {
            return false;
        }
        TreeMap<Integer, Integer> count = new TreeMap<>();
        for (int num : hand) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }
        while (!count.isEmpty()) {
            int first = count.firstKey();
            for (int i = 0; i < groupSize; i++) {
                int current = first + i;
                if (!count.containsKey(current)) {
                    return false;
                }
                int cnt = count.get(current);
                if (cnt == 1) {
                    count.remove(current);
                } else {
                    count.put(current, cnt - 1);
                }
            }
        }
        return true;
    }
}