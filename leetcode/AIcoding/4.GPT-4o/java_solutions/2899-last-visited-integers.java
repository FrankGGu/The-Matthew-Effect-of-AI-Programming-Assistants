class Solution {
    public int[] getLastVisited(int[] nums, int n) {
        Set<Integer> visited = new HashSet<>();
        List<Integer> result = new ArrayList<>();

        for (int num : nums) {
            if (visited.size() < n) {
                if (!visited.contains(num)) {
                    visited.add(num);
                    result.add(num);
                }
            } else {
                if (!visited.contains(num)) {
                    visited.remove(result.remove(0));
                    visited.add(num);
                    result.add(num);
                }
            }
        }

        return result.stream().mapToInt(i -> i).toArray();
    }
}