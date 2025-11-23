class Solution {
    public int[] findDiagonalOrder(List<List<Integer>> nums) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        int maxKey = 0;
        int count = 0;

        for (int i = 0; i < nums.size(); i++) {
            for (int j = 0; j < nums.get(i).size(); j++) {
                int key = i + j;
                map.putIfAbsent(key, new ArrayList<>());
                map.get(key).add(nums.get(i).get(j));
                maxKey = Math.max(maxKey, key);
                count++;
            }
        }

        int[] result = new int[count];
        int index = 0;

        for (int key = 0; key <= maxKey; key++) {
            List<Integer> list = map.get(key);
            if (list == null) continue;
            for (int i = list.size() - 1; i >= 0; i--) {
                result[index++] = list.get(i);
            }
        }

        return result;
    }
}