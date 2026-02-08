class Solution {
    public List<Integer> filterRestaurants(int[][] restaurants, int veganFriendly, int maxPrice, int maxDistance) {
        List<int[]> filtered = new ArrayList<>();
        for (int[] r : restaurants) {
            if ((veganFriendly == 0 || r[2] == veganFriendly) && r[3] <= maxPrice && r[4] <= maxDistance) {
                filtered.add(r);
            }
        }

        Collections.sort(filtered, (a, b) -> {
            if (a[1] != b[1]) {
                return b[1] - a[1];
            } else {
                return b[0] - a[0];
            }
        });

        List<Integer> result = new ArrayList<>();
        for (int[] r : filtered) {
            result.add(r[0]);
        }
        return result;
    }
}