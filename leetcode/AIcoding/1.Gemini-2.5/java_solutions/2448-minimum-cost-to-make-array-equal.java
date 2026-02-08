import java.util.Arrays;
import java.util.Comparator;

class Solution {

    private static class Item {
        int num;
        int cost;

        Item(int num, int cost) {
            this.num = num;
            this.cost = cost;
        }
    }

    public long minCost(int[] nums, int[] cost) {
        int n = nums.length;
        Item[] items = new Item[n];
        long totalCostSum = 0;

        for (int i = 0; i < n; i++) {
            items[i] = new Item(nums[i], cost[i]);
            totalCostSum += cost[i];
        }

        Arrays.sort(items, Comparator.comparingInt(item -> item.num));

        long currentCostAccumulated = 0;
        int targetNum = -1;

        for (int i = 0; i < n; i++) {
            currentCostAccumulated += items[i].cost;
            if (currentCostAccumulated * 2 >= totalCostSum) {
                targetNum = items[i].num;
                break;
            }
        }

        long minTotalCost = 0;
        for (int i = 0; i < n; i++) {
            minTotalCost += (long) cost[i] * Math.abs(nums[i] - targetNum);
        }

        return minTotalCost;
    }
}