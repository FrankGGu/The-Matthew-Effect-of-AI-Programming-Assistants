class Solution {
    public int[] beautifulArray(int n) {
        List<Integer> result = new ArrayList<>();
        result.add(1);

        while (result.size() < n) {
            List<Integer> temp = new ArrayList<>();
            for (int num : result) {
                if (2 * num - 1 <= n) {
                    temp.add(2 * num - 1);
                }
            }
            for (int num : result) {
                if (2 * num <= n) {
                    temp.add(2 * num);
                }
            }
            result = temp;
        }

        int[] ans = new int[result.size()];
        for (int i = 0; i < ans.length; i++) {
            ans[i] = result.get(i);
        }
        return ans;
    }
}