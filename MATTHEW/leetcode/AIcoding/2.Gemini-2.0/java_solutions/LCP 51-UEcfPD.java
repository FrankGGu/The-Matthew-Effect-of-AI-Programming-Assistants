public class Solution {

    private int ans = 0;
    private int[][] satisfaction;
    private int[] limit;
    private int n;

    public int perfectMenu(int[] materials, int[][] cookbooks, int[][] attribute, int limit) {
        this.n = cookbooks.length;
        this.satisfaction = attribute;
        this.limit = new int[]{limit, 0};
        int[] cost = new int[5];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 5; j++) {
                materials[j] -= cookbooks[i][j];
                cost[j] = cookbooks[i][j];
            }
        }
        dfs(0, materials, 0, cookbooks);
        if (ans == 0) {
            return -1;
        }
        return ans;
    }

    private void dfs(int index, int[] materials, int sum, int[][] cookbooks) {
        if (index == n) {
            if (sum >= limit[0]) {
                ans = Math.max(ans, limit[1]);
            }
            return;
        }

        dfs(index + 1, materials, sum, cookbooks);

        boolean flag = true;
        for (int i = 0; i < 5; i++) {
            if (materials[i] < cookbooks[index][i]) {
                flag = false;
                break;
            }
        }

        if (flag) {
            for (int i = 0; i < 5; i++) {
                materials[i] -= cookbooks[index][i];
            }
            limit[1] += satisfaction[index][0];
            dfs(index + 1, materials, sum + satisfaction[index][1], cookbooks);
            for (int i = 0; i < 5; i++) {
                materials[i] += cookbooks[index][i];
            }
            limit[1] -= satisfaction[index][0];
        }
    }
}