class Solution {
    public int[] shortestSeq(int[] big, int[] small) {
        Map<Integer, Integer> target = new HashMap<>();
        for (int num : small) {
            target.put(num, target.getOrDefault(num, 0) + 1);
        }

        int left = 0, right = 0;
        int count = small.length;
        int minLen = Integer.MAX_VALUE;
        int[] result = new int[0];
        Map<Integer, Integer> window = new HashMap<>();

        while (right < big.length) {
            int num = big[right];
            if (target.containsKey(num)) {
                window.put(num, window.getOrDefault(num, 0) + 1);
                if (window.get(num) <= target.get(num)) {
                    count--;
                }
            }
            right++;

            while (count == 0) {
                if (right - left < minLen) {
                    minLen = right - left;
                    result = new int[]{left, right - 1};
                }
                int leftNum = big[left];
                if (target.containsKey(leftNum)) {
                    window.put(leftNum, window.get(leftNum) - 1);
                    if (window.get(leftNum) < target.get(leftNum)) {
                        count++;
                    }
                }
                left++;
            }
        }

        return result;
    }
}