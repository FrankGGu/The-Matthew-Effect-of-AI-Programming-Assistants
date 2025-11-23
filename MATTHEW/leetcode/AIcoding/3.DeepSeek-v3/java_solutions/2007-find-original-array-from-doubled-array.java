class Solution {
    public int[] findOriginalArray(int[] changed) {
        if (changed.length % 2 != 0) {
            return new int[0];
        }

        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : changed) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        Arrays.sort(changed);
        int[] original = new int[changed.length / 2];
        int index = 0;

        for (int num : changed) {
            if (freq.get(num) == 0) {
                continue;
            }
            int doubled = num * 2;
            if (freq.containsKey(doubled) && freq.get(doubled) > 0) {
                if (num == 0) {
                    if (freq.get(num) % 2 != 0) {
                        return new int[0];
                    }
                }
                original[index++] = num;
                freq.put(num, freq.get(num) - 1);
                freq.put(doubled, freq.get(doubled) - 1);
            } else {
                return new int[0];
            }
        }

        return original;
    }
}