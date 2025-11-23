class Solution {
    public int subarraysDivByK(int[] A, int K) {
        int count = 0, sum = 0;
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, 1);

        for (int num : A) {
            sum += num;
            int mod = ((sum % K) + K) % K;
            count += map.getOrDefault(mod, 0);
            map.put(mod, map.getOrDefault(mod, 0) + 1);
        }

        return count;
    }
}