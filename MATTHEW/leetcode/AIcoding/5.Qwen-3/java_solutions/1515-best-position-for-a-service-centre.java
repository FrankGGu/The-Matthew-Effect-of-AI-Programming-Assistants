public class Solution {

import java.util.*;

public class Solution {
    public double[] getBestPosition(double[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        double[] result = new double[2];

        double left = 0, right = 1000000;
        for (int i = 0; i < 100; i++) {
            double mid1 = left + (right - left) / 3;
            double mid2 = right - (right - left) / 3;
            double cost1 = calculateCost(grid, mid1);
            double cost2 = calculateCost(grid, mid2);
            if (cost1 < cost2) {
                right = mid2;
            } else {
                left = mid1;
            }
        }

        double minCost = Double.MAX_VALUE;
        for (double x = left; x <= right; x += 0.001) {
            double cost = calculateCost(grid, x);
            if (cost < minCost) {
                minCost = cost;
                result[0] = x;
            }
        }

        left = 0;
        right = 1000000;
        for (int i = 0; i < 100; i++) {
            double mid1 = left + (right - left) / 3;
            double mid2 = right - (right - left) / 3;
            double cost1 = calculateCost(grid, mid1);
            double cost2 = calculateCost(grid, mid2);
            if (cost1 < cost2) {
                right = mid2;
            } else {
                left = mid1;
            }
        }

        minCost = Double.MAX_VALUE;
        for (double y = left; y <= right; y += 0.001) {
            double cost = calculateCost(grid, y);
            if (cost < minCost) {
                minCost = cost;
                result[1] = y;
            }
        }

        return result;
    }

    private double calculateCost(double[][] grid, double x) {
        double cost = 0;
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                cost += Math.sqrt(Math.pow(x - grid[i][j], 2) + Math.pow(i - j, 2));
            }
        }
        return cost;
    }
}
}