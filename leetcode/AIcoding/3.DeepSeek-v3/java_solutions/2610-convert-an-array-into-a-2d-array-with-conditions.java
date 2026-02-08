class Solution {
    public List<List<Integer>> findMatrix(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        List<List<Integer>> result = new ArrayList<>();
        while (!freq.isEmpty()) {
            List<Integer> row = new ArrayList<>();
            for (Iterator<Map.Entry<Integer, Integer>> it = freq.entrySet().iterator(); it.hasNext(); ) {
                Map.Entry<Integer, Integer> entry = it.next();
                row.add(entry.getKey());
                entry.setValue(entry.getValue() - 1);
                if (entry.getValue() == 0) {
                    it.remove();
                }
            }
            result.add(row);
        }

        return result;
    }
}