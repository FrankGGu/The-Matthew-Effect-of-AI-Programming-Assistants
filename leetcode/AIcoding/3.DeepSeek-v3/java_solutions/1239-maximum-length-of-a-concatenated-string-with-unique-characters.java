class Solution {
    public int maxLength(List<String> arr) {
        List<Integer> dp = new ArrayList<>();
        dp.add(0);
        int max = 0;

        for (String s : arr) {
            int mask = 0, dup = 0;
            for (char c : s.toCharArray()) {
                int bit = 1 << (c - 'a');
                if ((mask & bit) != 0) {
                    dup = 1;
                    break;
                }
                mask |= bit;
            }
            if (dup == 1) continue;

            int size = dp.size();
            for (int i = 0; i < size; i++) {
                int m = dp.get(i);
                if ((m & mask) != 0) continue;
                int newMask = m | mask;
                dp.add(newMask);
                max = Math.max(max, Integer.bitCount(newMask));
            }
        }

        return max;
    }
}