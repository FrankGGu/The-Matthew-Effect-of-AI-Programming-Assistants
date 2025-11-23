class Solution {
    public int inventoryManagement(int[][] orders) {
        int n = orders.length;
        long[] inventory = new long[n];
        for (int i = 0; i < n; i++) {
            inventory[i] = orders[i][0];
        }

        long totalCost = 0;
        for (int i = 0; i < n; i++) {
            int orderQuantity = orders[i][1];
            long currentInventory = inventory[i];
            if (currentInventory < orderQuantity) {
                totalCost += (orderQuantity - currentInventory) * orders[i][2];
                inventory[i] = 0;
            } else {
                inventory[i] -= orderQuantity;
            }
        }
        return (int)(totalCost % 1000000007);
    }
}