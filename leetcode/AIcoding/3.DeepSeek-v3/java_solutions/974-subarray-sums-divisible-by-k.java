class Solution {
    public int subarraysDivByK(int[] nums, int k) {
        int count = 0;
        int sum = 0;
        int[] modCount = new int[k];
        modCount[0] = 1;

        for (int num : nums) {
            sum += num;
            int mod = (sum % k + k) % k;
            count += modCount[mod];
            modCount[mod]++;
        }

        return count;
    }
}